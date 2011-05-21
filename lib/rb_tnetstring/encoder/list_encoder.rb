module RbTNetstring

  class ListEncoder < Encoder 
    def initialize(obj)
      @obj = obj
    end

    def encode
      contents = @obj.map {|item| super(item)}.join
      "#{contents.length}:#{contents}]"
    end
  end

end
