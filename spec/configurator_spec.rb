require "spec_helper"

describe Configulations do
  describe "looks like an object" do
    it "allows for dot-style syntax accessors." do
      c = Configulations.new
      c.development.boo = true
      c.development.boo.should == true
    end

    it "loads yml properties" do
      c = Configulations.new
      c.development.host.should == "localhost"
    end

    it "loads json properties" do
      c = Configulations.new
      c.foo.name.should == 'foo'
    end

    it "loves lazy duck typing" do
      c = Configulations.new
      c.server.content_types.should be_a_kind_of Array
      c.server.content_types.length.should == 3
    end

    it "responds to known booleans." do
      c = Configulations.new
      c.server.cache_enabled?.should == true
      c.server.cache_enabled?.should be_true
    end
  end

  describe "Inheritance" do
    context "when a configulation is initialized" do
      before do
        @config = Configulations.new
      end

      context "when child introduces new config option" do
        it "is appended and namespaced to parent" do
          # config/parent/child.json specifies xyz = foobarbaz
          @config.parent.child.xyz.should == "foobarbaz"
        end
      end

      context "when child and parent share option" do
        it "overwrites parent config option" do
          # config/parent.json specifies alignment = good
          # config/parent/child.json specifies alignment = evil
          @config.parent.alignment.should == "evil"
        end
      end
    end
  end
end

