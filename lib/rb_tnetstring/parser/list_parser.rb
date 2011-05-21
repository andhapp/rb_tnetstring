module RbTNetstring

  class ListParser < RbTNetstring::Parser

    def initialize(payload)
      @payload = payload
    end
    
    def parse
      return [] if @payload.length == 0
      list = []
      value, remain = super(@payload)
      list << value

      while remain.length > 0
        value, remain = super(remain)
        list << value
      end
      list
    end
  end

end
