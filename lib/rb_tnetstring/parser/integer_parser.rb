module RbTNetstring

  class IntegerParser < Parser

    def initialize(payload)
      @payload = payload
    end

    def parse
      @payload.to_i
    end
  end

end
