module RbTNetstring

  class DictionaryParser < Parser
    
    include Helper
     
    ODD_KEYS = "Unbalanced dictionary store"
    NULL_NOT_ALLOWED = "Got an invalid value, null not allowed"

    def initialize(payload)
      @payload = payload  
    end

    def parse
      return {} if @payload.length == 0

      key, extra = super(@payload) 
      assert key.kind_of?(String), KEY_MUST_BE_STRING 
      assert extra, ODD_KEYS 
      value, extra = super(extra)
      assert value, NULL_NOT_ALLOWED 
      result = {key => value}
      result
    end
   
  end

end
