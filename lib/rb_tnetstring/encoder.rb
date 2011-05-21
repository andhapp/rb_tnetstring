module RbTNetstring
  
  class Encoder
    
    include Helper
    
    def encode(obj)
      if type = ENCODE_TYPES[obj.class]
      else assert false, "Object must be of a primitive type: #{obj.inspect}"
      end
      type.new(obj).encode
    end

  end

end
