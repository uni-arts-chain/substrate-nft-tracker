# frozen_string_literal: true

require_relative "tracker/version"

require "logger"
require "scale"
require "json"
require "testnets/pangolin"
require "testnets/pangolin_contract_helper"
require "nft_helper"
require "ethereum"
require "bytes"
require "erc721_contract"
require "erc1155_contract"

module Tracker
  class NotErc721ContractError < StandardError; end
  class NotErc1155ContractError < StandardError; end

  class <<self
    attr_accessor :logger

    def get_erc721_abi
      file = File.join __dir__, "erc721.json"
      File.open(file).read
    end

    def get_erc1155_abi
      file = File.join __dir__, "erc1155.json"
      File.open(file).read
    end
  end
end

