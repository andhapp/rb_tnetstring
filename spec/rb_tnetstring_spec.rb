require 'spec_helper'

describe RbTNetstring do
  context "parsing" do

    it "parses an integer" do
      TNetstring.parse('5:12345#')[0].should == 12345
    end

    it "parses an empty string" do
      TNetstring.parse('0:,')[0].should == ""
    end

    it "parses a string" do
      TNetstring.parse('12:this is cool,')[0].should == "this is cool"
    end

    it "parses to an empty array" do
      TNetstring.parse('0:]')[0].should == []
    end

    it "parses an arbitrary array of ints and strings" do
      TNetstring.parse('24:5:12345#5:67890#5:xxxxx,]')[0].should == [12345, 67890, 'xxxxx']
    end

    it "parses to an empty hash" do
      TNetstring.parse('0:}')[0].should == {}
    end

    it "parses an arbitrary hash of ints, strings, and arrays" do
      TNetstring.parse('34:5:hello,22:11:12345678901#4:this,]}')[0].should == {"hello" => [12345678901, 'this']}
    end

    it "parses a null" do
      TNetstring.parse('0:~')[0].should == nil
    end

    it "raises on a lengthy null" do
      expect { TNetstring.parse('1:x~')[0] }.to raise_error(TNetstring::ProcessError)
    end

    it "parses a boolean" do
      TNetstring.parse('4:true!')[0].should == true
    end

    it "parses a float" do
      TNetstring.parse('7:0000.10^')[0].should == 0.1
    end

    it "parses a negative float" do
      TNetstring.parse('8:-0000.10^')[0].should == -0.1
    end

    it "parses an arbitraty array of ints and floats" do
      TNetstring.parse('25:5:12345#5:67890#6:-00.10^]')[0].should == [12345, 67890, -0.1]
    end

    it "raises on a bad boolean" do
      expect { TNetstring.parse('5:pants!')[0] }.to raise_error(TNetstring::ProcessError)
    end

    it "raises with negative length" do
      expect { TNetstring.parse("-1:asd,")[0] }.to raise_error(TNetstring::ProcessError)
    end

    it "raises with absurd length" do
      expect { TNetstring.parse("1000000000:asd,")[0] }.to raise_error(TNetstring::ProcessError)
    end

    it "raises on unknown type" do
      expect { TNetstring.parse('0:)')[0] }.to raise_error(TNetstring::ProcessError)
    end
  end

  context "encoding" do
    it "encodes an integer" do
      TNetstring.encode(42).should == "2:42#"
    end

    it "encodes a string" do
      TNetstring.encode("hello world").should == "11:hello world,"
    end

    it "encodes a float" do
      TNetstring.encode(0.01).should == "4:0.01^"
    end

    it "encodes a negaitive float" do
      TNetstring.encode(-0.01).should == "5:-0.01^"
    end

    context "boolean" do
      it "encodes true as 'true'" do
        TNetstring.encode(true).should == "4:true!"
      end

      it "encodes false as 'false'" do
        TNetstring.encode(false).should == "5:false!"
      end
    end

    it "encodes nil" do
      TNetstring.encode(nil).should == "0:~"
    end

    context "arrays" do
      it "encodes an empty array" do
        TNetstring.encode([]).should == "0:]"
      end

      it "encodes an array of arbitrary elements" do
        TNetstring.encode(["cat", false, 123]).should == "20:3:cat,5:false!3:123#]"
      end

      it "encodes nested arrays" do
        TNetstring.encode(["cat", [false, 123]]).should == "24:3:cat,14:5:false!3:123#]]"
      end
    end

    context "hashes" do
      it "encodes an empty hash" do
        TNetstring.encode({}).should == "0:}"
      end

      it "encodes an arbitrary hash of primitives and arrays" do
        TNetstring.encode({"hello" => [12345678901, 'this']}).should == '34:5:hello,22:11:12345678901#4:this,]}'
      end

      it "encodes nested hashes" do
        TNetstring.encode({"hello" => {"world" => 42}}).should == '25:5:hello,13:5:world,2:42#}}'
      end

      it "rejects non-String keys" do
        expect { TNetstring.encode({123 => "456"}) }.to raise_error(TNetstring::ProcessError)
      end
    end

    it "rejects non-primitives" do
      expect { TNetstring.encode(Object.new) }.to raise_error(TNetstring::ProcessError)
    end
  end
end
