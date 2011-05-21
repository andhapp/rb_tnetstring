module RbTNetstring

  class DictionaryEncoder < Encoder 
    def initialize(obj)
      @obj = obj
    end

    def encode
      contents = @obj.map do |key, value|
        assert key.kind_of?(String), "Dictionary keys must be Strings"
        "#{super(key)}#{super(value)}"
      end.join
      "#{contents.length}:#{contents}}"
    end
  end

end
