# frozen_string_literal: true

require_relative "tracker/version"

require "logger"
require "scale"
require "json"
require "testnets/pangolin"
require "nft_helper"

module Tracker
  class <<self
    attr_accessor :logger
  end
end

