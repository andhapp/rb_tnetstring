module RbTNetstring
   
  module Helper  
    def assert(truth, message) # :nodoc:
      raise ::RbTNetstring::ProcessError.new(message) unless truth
    end    
  end
end
