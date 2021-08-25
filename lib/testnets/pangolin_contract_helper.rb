class PangolinContractHelper
  def get_name_and_symbol(address)
    contract = Erc721Contract.new(
      "https://pangolin-rpc.darwinia.network",
      address,
      "0xC5c1C9c3cEA2f4A68E540b18e63310310FD8af57"
    )
    [contract.name, contract.symbol]
  end

  def get_token_uri(address, token_id)
    contract = Erc721Contract.new(
      "https://pangolin-rpc.darwinia.network",
      address,
      "0xC5c1C9c3cEA2f4A68E540b18e63310310FD8af57"
    )
    contract.token_uri(token_id)
  end

  def get_uri(address, token_id)
    contract = Erc1155Contract.new(
      "https://pangolin-rpc.darwinia.network",
      address,
      "0xC5c1C9c3cEA2f4A68E540b18e63310310FD8af57"
    )
    contract.uri(token_id)
  end
end

