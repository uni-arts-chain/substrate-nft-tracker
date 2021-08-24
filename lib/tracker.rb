# frozen_string_literal: true

require_relative "tracker/version"

require "logger"
require "scale"
require "json"
require "testnets/pangolin"
require "testnets/pangolin_contract_helper"
require "nft_helper"
require "ethereum"

module Tracker
  class <<self
    attr_accessor :logger

    def get_erc721_abi
      file = File.join __dir__, "erc721.json"
      File.open(file).read
    end
  end
end

