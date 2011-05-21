module RbTNetstring

  class StringEncoder < ::RbTNetstring::Encoder 
    def initialize(obj)
      @obj = obj
    end

    def encode
      "#{@obj.length}:#{@obj},"
    end
  end

end
