require 'test_helper'
require 'umlify'
require 'ripper'
require 'pp'

describe "ToUml Visitor" do
  it "returns a UmlDiagram" do
    diagram = Ripper.sexp_raw( '' ).accept( Umlify::Visitors::ToUML.new )
    diagram.must_be_instance_of( Umlify::UmlClasses::UmlDiagram )
  end

  describe "with a class" do
    describe "when it's empty" do
      before do
        code = <<-CODE
        class Foo
        end
        CODE
        @diagram = Ripper.sexp_raw( code ).accept( Umlify::Visitors::ToUML.new )
      end

      it "creates a uml_class" do
        @diagram.respond_to?( :uml_classes ).must_equal( true )
        @diagram.uml_classes.length.must_equal( 1 )
      end

      it "sets the uml_class name" do
        @diagram.uml_classes.first.name.must_equal( 'Foo' )
      end

      it "sets the super if there is one" do
        code = <<-CODE
        class Foo < Sup
        end
        CODE
        @diagram = Ripper.sexp_raw( code ).accept( Umlify::Visitors::ToUML.new )
        @diagram.uml_classes.first.super.must_equal( 'Sup' )
      end
    end

    before do
      code = <<-CODE
      class Foo
        def say_hi( name )
          puts "hi"
        end

        def coffee
          CONST = 'test'
        end

        def say_bye
        end
      end
      CODE
      @diagram = Ripper.sexp_raw( code ).accept( Umlify::Visitors::ToUML.new )
    end

    it "finds method names" do
      @diagram.uml_classes.first.methods.must_include( 'say_hi' )
      @diagram.uml_classes.first.methods.must_include( 'say_bye' )
      @diagram.uml_classes.first.methods.must_include( 'coffee' )
    end

    it "finds constants" do
      @diagram.uml_classes.first.constants.length.must_equal( 1 )
      @diagram.uml_classes.first.constants.must_include( 'CONST' )
    end
  end

  describe "with many classes" do
    before do
      code = <<-CODE
      class Foo
        def say_hi( name )
          puts "hi"
        end

        def coffee
          CONST = 'test'
        end

        def say_bye
        end
      end

      class Bar < Whatever
        def relation
          Foo.new.say_hi
        end
      end
      CODE
      @diagram = Ripper.sexp_raw( code ).accept( Umlify::Visitors::ToUML.new )
    end

    it "creates two classes" do
      @diagram.respond_to?( :uml_classes ).must_equal( true )
      @diagram.uml_classes.length.must_equal( 2 )
    end

    it "creates a dependency between the two" do
      bar = @diagram.uml_classes.find { |c| c.name == 'Bar' }
      bar.respond_to?( :dependencies ).must_equal( true )
      bar.dependencies.length.must_equal( 1 )
      bar.dependencies.first.must_be_instance_of( Umlify::UmlClasses::UmlClass )
      bar.dependencies.first.name.must_equal( 'Foo' )

      foo = @diagram.uml_classes.find { |c| c.name == 'Foo' }
      foo.respond_to?( :dependencies ).must_equal( true )
      foo.dependencies.length.must_equal( 0 )
    end
  end
end
