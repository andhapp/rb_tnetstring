module RbTNetstring

  class BooleanEncoder < Encoder 
    def initialize(obj)
      @obj = obj
    end

    def encode
      bool_string = @obj.to_s
      "#{bool_string.length}:#{bool_string}!"
    end
  end

end
