module RbTNetstring

  class Parser

    def parse(tnetstring)
      payload = Payload.new(tnetstring)
      type = payload.parser_klass.new(payload.value)
      [type.parse, payload.remain]
    end
 
    class Payload
      
      include Helper
      
      MIN_LENGTH = 0
      MAX_LENGTH = 999_999_999 
      
      EMPTY_DATA = "Invalid data to parse; it's empty"
      DATA_LONGER_THAN_MAX_ALLOWED = "Data is longer than the specification allows"
      DATA_SHORTER_THAN_MIN_ALLOWED = "Data length cannot be negative"
      
      attr_accessor :parser_klass, :value, :remain

      def initialize(tnetstring)
        @value, @parser_klass, @remain = parse(tnetstring)
      end

      #TODO: Needs to be refactored
      def parse(data) # :nodoc:
        assert data, EMPTY_DATA
        length, extra = data.split(':', 2)

        length = length.to_i
        assert length <= MAX_LENGTH, DATA_LONGER_THAN_MAX_ALLOWED 
        assert length >= MIN_LENGTH, DATA_SHORTER_THAN_MIN_ALLOWED 

        payload, extra = extra[0, length], extra[length..-1]

        assert extra, "No payload type: #{payload}, #{extra}"
        payload_type_symbol, remain = extra[0,1], extra[1..-1]

        assert payload.length == length, "Data is wrong length: #{length} expected but was #{payload.length}"

        [payload, to_parser_klass(payload_type_symbol), remain]
      end

      private

        def to_parser_klass(payload_type_symbol)
          if type = PARSE_TYPES[payload_type_symbol]
          else assert false, "Invalid payload type: #{payload_type_symbol}"
          end
          type
        end
   
    end
    
  end

end
