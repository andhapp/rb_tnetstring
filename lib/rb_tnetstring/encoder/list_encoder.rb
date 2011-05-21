module RbTNetstring

  class ListEncoder < ::RbTNetstring::Encoder 
    def initialize(obj)
      @obj = obj
    end

    def encode
      contents = @obj.map {|item| super(item)}.join
      "#{contents.length}:#{contents}]"
    end
  end

end
