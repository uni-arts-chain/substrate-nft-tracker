class Erc721Contract
  # Why set a sender?
  # Because the Darwinia Pangolin Network checks the gas fee when it receives a message call.
  # So, it need a `from` address with some tokens
  # Is this a bug?
  def initialize(url, address, sender=nil)
    client = Ethereum::HttpClient.new(url)
    @contract = Ethereum::Contract.create(name: "Erc721Contract", address: address, abi: Tracker.get_erc721_abi, client: client)
    @contract.gas_price = 120000000000
    if not sender.nil?
      @contract.sender = sender
    end

    raise Tracker::NotErc721ContractError.new(address) unless @contract.call.supports_interface(Bytes.new("0x80ac58cd"))
    raise Tracker::Erc721WithoutMetadata.new(address) unless @contract.call.supports_interface(Bytes.new("0x5b5e139f"))
  end

  def name
    @contract.call.name()
  end

  def symbol
    @contract.call.symbol()
  end

  def token_uri(token_id)
    @contract.call.token_uri(token_id)
  end
end
