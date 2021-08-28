# Substrate Nft Tracker

This is a tool for tracking NFT in the evm pallet of substrate based blockchain.

This tool is part of [The NFT Explorer](https://github.com/uni-arts-chain/uniscan). It gets NFT-related events by listening to the substrate's native events.

The advantage of this approach is that it does not rely on the rpc interfaces provided by the Ethereum, but uses the native rpc interface provided by substrate. This approach is more reliable in the polkadot ecosystem.

## Usage
### Installation

```bash
$ gem install substrate-nft-tracker
```

### Run

Run an example(it is for Darwinia Pangolin Network) that has been implemented here. 

```bash
$ pangolin 1234
```

The only parameter is the start block height.

### Develop a new NFT tracker for a new blockchain

You can create a new project yourself, or you can fork the project and add files on top of it, I recommend the latter:

1. Create the client of the blockchain

   You can refer to `lib/testnets/pangolin.rb` as an example. 

   You need to add types for this chain and implement two methods `get_latest_block_number()` and `get_events_by_block_number(block_number)`.

2. Create an executable program

   You can refer to `exe/pangolin` as an example.

## Test

run `rake spec` to run the tests. 

## Docker

```bash
$ docker build -t substrate-nft-tracker .
$ docker run -it --rm substrate-nft-tracker pangolin 167421
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/uni-arts-chain/substrate-nft-tracker. 

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
