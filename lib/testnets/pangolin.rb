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

  def get_latest_block_number()
    head = @substrate_client.chain_getFinalizedHead
    header = @substrate_client.chain_getHeader head
    header["number"].to_i(16)
  end

  def get_events_by_block_number(block_number)
    block_hash = @substrate_client.chain_getBlockHash(block_number)
    @substrate_client.get_block_events(block_hash)[1]
  end
end
