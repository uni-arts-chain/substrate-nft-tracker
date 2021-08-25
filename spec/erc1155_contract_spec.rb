# frozen_string_literal: true

RSpec.describe Erc1155Contract do
  it "can be initialized from a erc1155 contract" do
    expect {
      Erc1155Contract.new(
        "https://pangolin-rpc.darwinia.network",
        "0xd429dbe8113213e08cf10b11b291d88e72b45dc1", # <- erc1155 contract
        "0xC5c1C9c3cEA2f4A68E540b18e63310310FD8af57"
      )
    }.not_to raise_error
  end

  it "can not be initialized from a non-erc1155 contract" do
    expect {
      Erc1155Contract.new(
        "https://pangolin-rpc.darwinia.network",
        "0xbd9058bed767e006dbe4ab1ba85446401b1daafc", # <- not erc1155 contract
        "0xC5c1C9c3cEA2f4A68E540b18e63310310FD8af57"
      )
    }.to raise_error(Tracker::NotErc1155ContractError)
  end

  it "can not be initialized from a non-existent address" do
    expect {
      Erc1155Contract.new(
        "https://pangolin-rpc.darwinia.network",
        "0x5e9d61A891FB6760DDe5Af3a4AC5A4D0BaE55460", # <- non-existent address
        "0xC5c1C9c3cEA2f4A68E540b18e63310310FD8af57"
      )
    }.to raise_error(ArgumentError)
  end

  it "can not be initialized from a erc1155 contract without metadata" do
    expect {
      Erc1155Contract.new(
        "https://pangolin-rpc.darwinia.network",
        "0x1Cc1D7F55D5540041f869cF94c1294A0D95992C0", # <- erc1155 contract without metadata
        "0xC5c1C9c3cEA2f4A68E540b18e63310310FD8af57"
      )
    }.to raise_error(Tracker::Erc1155WithoutMetadata)
  end
end
