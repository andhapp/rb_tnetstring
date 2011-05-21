module RbTNetstring
  class NullParser < RbTNetstring::Parser
  
    include ::RbTNetstring::Helper
    
    def initialize(payload)
      @payload = payload
    end
  
    def parse
      assert @payload.length == 0, "Payload must be 0 length for null"
      nil
    end

  end
end
