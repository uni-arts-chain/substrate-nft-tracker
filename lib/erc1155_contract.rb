class Erc1155Contract
  # When need a sender? see Erc721Contract
  def initialize(url, address, sender=nil)
    client = Ethereum::HttpClient.new(url)
    @contract = Ethereum::Contract.create(name: "Erc1155Contract", address: address, abi: Tracker.get_erc1155_abi, client: client)
    if not sender.nil?
      @contract.sender = sender
    end

    raise Tracker::NotErc1155ContractError unless @contract.call.supports_interface(Bytes.new("0xd9b67a26"))
  end

  def uri(token_id)
    @contract.call.uri(token_id)
  end
end