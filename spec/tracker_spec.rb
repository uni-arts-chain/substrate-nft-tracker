# frozen_string_literal: true

RSpec.describe SubstrateEvmNftHelper do
  let(:helper) { 
    pangolin = Pangolin.new("wss://pangolin-rpc.darwinia.network")
    SubstrateEvmNftHelper.new(pangolin)
  }

  it "can get evm erc721 events" do
    erc721_events, erc1155_events = helper.get_evm_nft_events(156811)
    expect(erc721_events.length).to eq(1)
    expect(erc1155_events.length).to eq(0)
    expect(erc721_events[0][:address]).to eq("0xbd9058bed767e006dbe4ab1ba85446401b1daafc")
    expect(erc721_events[0][:from]).to eq("0x0000000000000000000000000000000000000000")
    expect(erc721_events[0][:to]).to eq("0xc5c1c9c3cea2f4a68e540b18e63310310fd8af57")
    expect(erc721_events[0][:token_id]).to eq(0)
  end

  it "can get evm erc1155 events" do
    erc721_events, erc1155_events = helper.get_evm_nft_events(167421)
    expect(erc721_events.length).to eq(0)
    expect(erc1155_events.length).to eq(1)
    expect(erc1155_events[0][:address]).to eq("0xd429dbe8113213e08cf10b11b291d88e72b45dc1")
    expect(erc1155_events[0][:from]).to eq("0x0000000000000000000000000000000000000000")
    expect(erc1155_events[0][:to]).to eq("0xc5c1c9c3cea2f4a68e540b18e63310310fd8af57")
    expect(erc1155_events[0][:token_id]).to eq(888)
    expect(erc1155_events[0][:amount]).to eq(9999)
  end
end
