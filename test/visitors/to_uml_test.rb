require 'test_helper'
require 'umlify'
require 'ripper'

describe "ToUml Visitor" do
  it "returns a UmlDiagram" do
    diagram = Ripper.sexp_raw( '' ).accept( Umlify::Visitors::ToUML.new )
    diagram.must_be_instance_of( Umlify::UmlClasses::UmlDiagram )
  end

  it "works with empty classes" do
    # code = <<-CODE
    # class FooClass
    # end
    # CODE

    # puts Ripper.sexp_raw( code ).accept( Umlify::Visitors::ToUML.new )
  end

  it "works with classes with a parent"
  it "works with include"
end
