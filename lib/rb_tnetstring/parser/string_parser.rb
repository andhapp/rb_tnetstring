module RbTNetstring

  class StringParser < Parser

    def initialize(payload)
      @payload = payload
    end
    
    def parse
      @payload
    end
  end

end
