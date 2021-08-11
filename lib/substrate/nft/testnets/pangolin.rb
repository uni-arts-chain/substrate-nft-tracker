class Pangolin
  def initialize(rpc)
    @substrate_client = SubstrateClient.new(rpc)
    Scale::TypeRegistry.instance.custom_types = {
      "ExitSucceed": {
        "type": "enum",
        "type_mapping": [
          ["Stopped", "Null"],
          ["Returned", "Null"],
          ["Suicided", "Null"]
        ]
      },
      "ExitError": {
        "type": "enum",
        "type_mapping": [
          ["StackUnderflow", "Null"],
          ["StackOverflow", "Null"],
          ["InvalidJump", "Null"],
          ["InvalidRange", "Null"],
          ["DesignatedInvalid", "Null"],
          ["CallTooDeep", "Null"],
          ["CreateCollision", "Null"],
          ["CreateContractLimit", "Null"],
          ["OutOfOffset", "Null"],
          ["OutOfGas", "Null"],
          ["OutOfFund", "Null"],
          ["PCUnderflow", "Null"],
          ["CreateEmpty", "Null"],
          ["Other", "String"]
        ]
      },
      "ExitRevert": {
        "type": "enum",
        "type_mapping": [
          ["Reverted", "Null"],
        ]
      },
      "ExitFatal": {
        "type": "enum",
        "type_mapping": [
          ["NotSupported", "Null"],
          ["UnhandledInterrupt", "Null"],
          ["CallErrorAsFatal", "ExitError"],
          ["Other", "String"],
        ]
      },
      "ExitReason": {
        "type": "enum",
        "type_mapping": [
          ["Succeed", "ExitSucceed"],
          ["Error","ExitError"],
          ["Revert","ExitRevert"],
          ["Fatal","ExitFatal"]
        ]
      },
    }
  end

  def get_evm_nft_events(block_number)
    nft_helper = SubstrateEvmNftHelper.new(@substrate_client)
    nft_helper.get_evm_nft_events(block_number)
  end
end
