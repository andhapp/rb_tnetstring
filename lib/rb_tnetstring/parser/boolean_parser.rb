module RbTNetstring

  class BooleanParser < Parser
   
    include Helper
   
    MUST_BE_TRUE_OR_FALSE = "Boolean wasn't 'true' or 'false'"

    def initialize(payload)
      @payload = payload
    end
    
    def parse
      case @payload
      when "false"
        false
      when "true"
        true
      else
        assert false, MUST_BE_TRUE_OR_FALSE 
      end    
    end

  end

end
