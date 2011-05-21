module RbTNetstring

  class NullParser < Parser
  
    include Helper
    
    MUST_BE_0_LENGTH = "Payload must be 0 length for null"

    def initialize(payload)
      @payload = payload
    end
  
    def parse
      assert @payload.length == 0, MUST_BE_0_LENGTH   
      nil
    end

  end
end
