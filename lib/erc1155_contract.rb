class Erc1155Contract
  # When need a sender? see Erc721Contract
  def initialize(url, address, sender=nil)
    client = Ethereum::HttpClient.new(url)
    @contract = Ethereum::Contract.create(name: "Erc1155Contract", address: address, abi: Tracker.get_erc1155_abi, client: client)
    if not sender.nil?
      @contract.sender = sender
    end

    # raise err if the address is not a erc721 contract
    raise Tracker::NotErc1155ContractError unless @contract.call.supports_interface(Bytes.new("0xd9b67a26"))

    # raise err if this erc721 has no metadata
    raise Tracker::Erc1155WithoutMetadata.new(address) unless @contract.call.supports_interface(Bytes.new("0x0e89341c"))
  end

  def uri(token_id)
    @contract.call.uri(token_id)
  end
end
