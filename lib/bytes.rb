# There is a bug of ethereum.rb.
# https://github.com/EthWorks/ethereum.rb/blob/bd9a9333b44b145909b22f2092224083163b7cae/lib/ethereum/encoder.rb#L61
# If the value is a hex string, the encode result is wrong.
#
# It could also be that I don't know enough about this library, but this class can solve the problem.
class Bytes
  def initialize(hex_str)
    raise "Not valid hex string" if hex_str.length % 2 != 0
    @hex_str = hex_str
  end

  def bytes
    data = @hex_str.start_with?('0x') ? @hex_str[2..] : @hex_str
    data.scan(/../).map(&:hex)
  end
end

