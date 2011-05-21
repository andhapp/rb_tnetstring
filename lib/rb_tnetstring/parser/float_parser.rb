module RbTNetstring

  class FloatParser < RbTNetstring::Parser

    def initialize(payload)
      @payload = payload
    end
    
    def parse
      @payload.to_f
    end
  end

end
