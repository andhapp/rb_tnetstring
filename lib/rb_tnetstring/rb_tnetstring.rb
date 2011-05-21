require 'rb_tnetstring/helper'

require 'rb_tnetstring/parser'
require 'rb_tnetstring/parser/boolean_parser'
require 'rb_tnetstring/parser/dictionary_parser'
require 'rb_tnetstring/parser/float_parser'
require 'rb_tnetstring/parser/integer_parser'
require 'rb_tnetstring/parser/list_parser'
require 'rb_tnetstring/parser/null_parser'
require 'rb_tnetstring/parser/string_parser'

require 'rb_tnetstring/encoder'
require 'rb_tnetstring/encoder/boolean_encoder'
require 'rb_tnetstring/encoder/dictionary_encoder'
require 'rb_tnetstring/encoder/float_encoder'
require 'rb_tnetstring/encoder/integer_encoder'
require 'rb_tnetstring/encoder/list_encoder'
require 'rb_tnetstring/encoder/null_encoder'
require 'rb_tnetstring/encoder/string_encoder'

module RbTNetstring
  
  class ProcessError < StandardError; end
  
  ENCODE_TYPES = {
    Fixnum => ::RbTNetstring::IntegerEncoder,
    Bignum => ::RbTNetstring::IntegerEncoder, 
    Float => ::RbTNetstring::FloatEncoder,
    String => ::RbTNetstring::StringEncoder,
    Array => ::RbTNetstring::ListEncoder,
    Hash => ::RbTNetstring::DictionaryEncoder,
    NilClass => ::RbTNetstring::NullEncoder,
    TrueClass => ::RbTNetstring::BooleanEncoder,
    FalseClass => ::RbTNetstring::BooleanEncoder
  }

  PARSE_TYPES = {
    '#' => ::RbTNetstring::IntegerParser,
    '^' => ::RbTNetstring::FloatParser,
    ',' => ::RbTNetstring::StringParser, 
    ']' => ::RbTNetstring::ListParser,
    '}' => ::RbTNetstring::DictionaryParser,
    '~' => ::RbTNetstring::NullParser,
    '!' => ::RbTNetstring::BooleanParser
  }

  # Converts a tnetstring into the encoded data structure.
  #
  # It expects a string argument prefixed with a valid tnetstring and
  # returns a tuple of the parsed object and any remaining string input.
  #
  # === Example
  #
  #  str = '5:12345#'
  #  TNetstring.parse(str)
  #
  #  #=> [12345, '']
  #
  #  str = '11:hello world,abc123'
  #
  #  #=> ['hello world', 'abc123']
  #
  def self.parse(tnetstring)
    RbTNetstring::Parser.new.parse(tnetstring)
  end

  # Constructs a tnetstring out of the given object. Valid Ruby object types
  # include strings, integers, boolean values, nil, arrays, and hashes. Arrays
  # and hashes may contain any of the previous valid Ruby object types, but
  # hash keys must be strings.
  #
  # === Example
  #
  #  int = 12345
  #  TNetstring.encode(int)
  #
  #  #=> '5:12345#'
  #
  #  hash = {'hello' => 'world'}
  #  TNetstring.encode(hash)
  #
  #  #=> '16:5:hello,5:world,}'
  #
  def self.encode(obj)
    Encoder.new.encode(obj)
  end

end
