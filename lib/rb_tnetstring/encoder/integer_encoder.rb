module RbTNetstring

  class IntegerEncoder < ::RbTNetstring::Encoder 
    def initialize(obj)
      @obj = obj
    end

    def encode
      int_string = @obj.to_s
      "#{int_string.length}:#{int_string}#"
    end
  end

end

