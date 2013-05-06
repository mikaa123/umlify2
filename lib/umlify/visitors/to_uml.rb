module Umlify
  module Visitors
    class ToUML < SexpVisitor
      def initialize
        @uml_diagram = Umlify::UmlClasses::UmlDiagram.new
      end

      visitor_for :program do |sexp|
        sexp.args.stop_at( :class ) do |klass|
          @uml_diagram << klass.accept( self )
        end
        @uml_diagram.compute_dependencies!
      end

      visitor_for :class do |sexp|
        methods = []
        sexp.args.stop_at( :def ) do |arr|
          methods << arr.accept( self )
        end

        constants = []
        sexp.find( :bodystmt ).stop_at( :@const ) do |cst|
          constants << cst.accept( self )
        end

        Umlify::UmlClasses::UmlClass.new(
          name: sexp.find( :const_ref ).accept( self ),
          super: sexp.find( :var_ref ).accept( self ),
          methods: methods,
          constants: constants
        )
      end

      visitor_for :const_ref, :var_ref, :def do |sexp|
        sexp.args.first.accept( self )
      end

      visitor_for :const, :ident do |sexp|
        sexp.args.first
      end
    end
  end
end
