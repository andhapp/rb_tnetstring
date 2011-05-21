module RbTNetstring

  class NullEncoder < ::RbTNetstring::Encoder 
    def initialize(obj)
      @obj = obj
    end

    def encode
      "0:~"      
    end
  end

end
