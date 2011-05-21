module RbTNetstring

  class DictionaryParser < Parser
    
    include Helper
     
    def initialize(payload)
      @payload = payload  
    end

    def parse
      return {} if @payload.length == 0

      key, extra = super(@payload)
      assert key.kind_of?(String), "Dictionary keys must be Strings"
      assert extra, "Unbalanced dictionary store"
      value, extra = super(extra)
      assert value, "Got an invalid value, null not allowed"
      result = {key => value}
      result
    end
   
  end

end
