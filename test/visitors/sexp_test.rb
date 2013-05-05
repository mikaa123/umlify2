require 'test_helper'
require 'umlify/visitors/sexp'

describe "SExp" do
  describe "#initialize" do
    it "raises an error if not initialized with a s-exp" do
      assert_raises( Umlify::Visitors::SExpError ) { Umlify::Visitors::SExp.new( '' ) }
      assert_raises( Umlify::Visitors::SExpError ) { Umlify::Visitors::SExp.new( [] ) }
      assert_raises( Umlify::Visitors::SExpError ) { Umlify::Visitors::SExp.new( [[]] ) }
    end
      
    it "creates a s-exp when initialized correctly" do
      s = Umlify::Visitors::SExp.new( [:foo] )
      assert_equal( s.op, :foo )
      assert_equal( s.args, [] )

      s = Umlify::Visitors::SExp.new( [:foo, []] )
      assert_equal( s.op, :foo )
      assert_equal( s.args, [[]] )

      s = Umlify::Visitors::SExp.new( [:@foo, []] )
      assert_equal( s.op, :foo )
      assert_equal( s.args, [[]] )
    end
  end

  describe "#find" do
    before do
      @sexp = Umlify::Visitors::SExp.new( [:foo, [:bar], [:bar, 2], [:baz]] )
    end

    it "returns the first child s-expression to matches the given op code" do
      @sexp.find( :bar ).must_equal( [:bar] )
    end

    it "returns nil when no sexp is found" do
      @sexp.find( :qux ).must_be_nil
    end
  end
end
