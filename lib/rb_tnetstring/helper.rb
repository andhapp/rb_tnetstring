module RbTNetstring
   
  module Helper  
    def assert(truth, message) # :nodoc:
      raise ProcessError.new(message) unless truth
    end    
  end
end
