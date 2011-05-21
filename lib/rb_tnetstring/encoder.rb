module RbTNetstring
  
  class Encoder
    
    include Helper
    
    MUST_BE_PRIMITIVE_TYPE = "Object must be of a primitive type:"

    def encode(obj)
      if type = ENCODE_TYPES[obj.class]
      else assert false, "#{MUST_BE_PRIMITIVE_TYPE} #{obj}" 
      end
      type.new(obj).encode
    end

  end

end
