module RbTNetstring

  class StringParser < RbTNetstring::Parser

    def initialize(payload)
      @payload = payload
    end
    
    def parse
      @payload
    end
  end

end
