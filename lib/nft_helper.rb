class SubstrateEvmNftHelper
  attr_reader :client    
  def initialize(client)
    @client = client
  end

  def track_nft(start_from)
    latest_block_number = @client.get_latest_block_number
    Tracker::logger.debug "The lasest block number is #{latest_block_number}"

    while true
      begin
        if start_from <= latest_block_number
          Tracker::logger.info "Scan block #{start_from}"
          erc721_events, erc1155_events = get_evm_nft_events(start_from)
          Tracker::logger.debug "#{erc721_events.length} erc721 events scanned"
          Tracker::logger.debug "#{erc1155_events.length} erc1155 events scanned"
          yield erc721_events, erc1155_events
          start_from += 1
        else
          Tracker::logger.debug "Sleep 12 seconds."
          sleep(12)
          latest_block_number = @client.get_latest_block_number
          Tracker::logger.debug "The lasest block number is #{latest_block_number}"
        end
      rescue => ex
        Tracker::logger.error ex
        Tracker::logger.error ex.backtrace
        Tracker::logger.debug "Sleep 30 seconds."
        sleep(30)
      end
    end
  end

  def get_evm_nft_events(block_number)
    # ERC721
    erc721_transfer_topic = "0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef" 

    # ERC1155
    erc1155_transfer_single = "0xc3d58168c5ae7397731d063d5bbf3d657854427343f4c083240f7aacaa2d0f62"
    erc1155_transfer_batch  = "0x4a39dc06d4c0dbc64b70af90fd698a233a518aa5d07e595d983b8c0526c8f7fb"

    erc721_events = []
    erc1155_events = []
    @client.get_events_by_block_number(block_number).each do |event|
      module_name = event[:module_metadata][:name]
      event_name = event[:event_metadata][:name]
      if module_name == "EVM" && event_name == "Log"

        event[:params].each do |param|
          if param[:name] == "Log"
            address = param[:value][:address]
            topics = param[:value][:topics]
            data = param[:value][:data]

            if topics[0] == erc721_transfer_topic
              if topics.length == 4
                from = "0x#{topics[1][26..]}"
                to = "0x#{topics[2][26..]}"
                token_id = topics[3].to_i(16)

                erc721_events << {from: from, to: to, token_id: token_id}
              end
            elsif topics[0] == erc1155_transfer_single 
              if topics.length == 4
                operator = "0x#{topics[1][26..]}"
                from = "0x#{topics[2][26..]}"
                to = "0x#{topics[3][26..]}"
                token_id = data[0...66].to_i(16)
                amount = data[66...130].to_i(16)

                erc1155_events << {from: from, to: to, token_id: token_id, amount: amount}
              end
            elsif topics[0] == erc1155_transfer_batch
              if topics.length == 4
                operator = "0x#{topics[1][26..]}"
                from = "0x#{topics[2][26..]}"
                to = "0x#{topics[3][26..]}"
                token_ids, amounts = get_token_ids_and_amounts(data)

                token_ids.each_with_index do |token_id, i|
                  amount = amounts[i]
                  erc1155_events << {from: from, to: to, token_id: token_id, amount: amount}
                end
              end
            end
          end
        end

      end
    end

    [erc721_events, erc1155_events]
  end

  private

    def get_token_ids_and_amounts(data)
      chunks = data[2..].scan(/.{1,64}/)[2..]
      len = chunks.length
      token_ids = chunks[1...len/2].map {|c| c.to_i(16) }
      amounts = chunks[len/2+1...len].map {|c| c.to_i(16) }
      [token_ids, amounts]
    end
end

