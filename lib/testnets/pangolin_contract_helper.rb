class PangolinContractHelper
  def initialize()
    @client = Ethereum::HttpClient.new("https://pangolin-rpc.darwinia.network")
  end

  def get_name_and_symbol(address)
    contract = Ethereum::Contract.create(name: "Contract", address: address, abi: Tracker.get_erc721_abi, client: @client)
    # Why set a sender?
    # Because the Darwinia Pangolin Network checks the gas fee when it receives a message call.
    # So, it need a `from` address with some tokens
    # Is this a bug?
    contract.sender = "0xC5c1C9c3cEA2f4A68E540b18e63310310FD8af57"
    [contract.call.name(), contract.call.symbol]
  end

  def get_token_uri(address, token_id)
    contract = Ethereum::Contract.create(name: "Contract", address: address, abi: Tracker.get_erc721_abi, client: @client)
    contract.sender = "0xC5c1C9c3cEA2f4A68E540b18e63310310FD8af57"
    contract.call.token_uri(token_id)
  end

end

