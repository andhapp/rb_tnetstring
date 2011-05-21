module RbTNetstring

  class DictionaryEncoder < Encoder

    def initialize(obj)
      @obj = obj
    end

    def encode
      contents = @obj.map do |key, value|
        assert key.kind_of?(String),  KEY_MUST_BE_STRING
        "#{super(key)}#{super(value)}"
      end.join
      "#{contents.length}:#{contents}}"
    end
  end

end
