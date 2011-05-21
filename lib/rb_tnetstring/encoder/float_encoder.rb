module RbTNetstring

  class FloatEncoder < ::RbTNetstring::Encoder 
    def initialize(obj)
      @obj = obj
    end

    def encode
      float_str = @obj.to_s
      "#{float_str.length}:#{float_str}^"
    end
  end

end
