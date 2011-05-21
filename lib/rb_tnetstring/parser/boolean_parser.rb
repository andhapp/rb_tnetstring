module RbTNetstring

  class BooleanParser < RbTNetstring::Parser
   
    include ::RbTNetstring::Helper
    
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
        assert false, "Boolean wasn't 'true' or 'false'"
      end    
    end

  end

end
