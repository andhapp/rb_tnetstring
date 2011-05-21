module RbTNetstring

  class StringEncoder < Encoder 
    def initialize(obj)
      @obj = obj
    end

    def encode
      "#{@obj.length}:#{@obj},"
    end
  end

end
