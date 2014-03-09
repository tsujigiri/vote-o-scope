class EnumSerializer
  attr_reader :enum

  def initialize(*enum)
    @enum = enum.flatten
  end

  def load(int)
    enum[int]
  end

  def dump(value)
    index = enum.find_index(value.to_sym)
    raise ValueInvalid if index.nil?
    index
  end

  class ValueInvalid < RuntimeError; end
end
