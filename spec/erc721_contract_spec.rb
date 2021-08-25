# frozen_string_literal: true

RSpec.describe Erc721Contract do
  it "can be initialized from a erc721 contract" do
    # Erc721Contract.new("https://main-light.eth.linkpool.io", "0xa3b7cee4e082183e69a03fc03476f28b12c545a7")
    expect {
      Erc721Contract.new(
        "https://pangolin-rpc.darwinia.network",
        "0xbd9058bed767e006dbe4ab1ba85446401b1daafc", # <- erc721 contract
        "0xC5c1C9c3cEA2f4A68E540b18e63310310FD8af57"
      )
    }.not_to raise_error
  end

  it "can not be initialized from a non-erc721 contract" do
    expect {
      Erc721Contract.new(
        "https://pangolin-rpc.darwinia.network",
        "0xd429dbe8113213e08cf10b11b291d88e72b45dc1", # <- not erc721 contract
        "0xC5c1C9c3cEA2f4A68E540b18e63310310FD8af57"
      )
    }.to raise_error(Tracker::NotErc721ContractError)
  end

end
