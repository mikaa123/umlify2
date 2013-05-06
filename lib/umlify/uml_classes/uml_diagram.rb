module Umlify
  module UmlClasses
    class UmlDiagram
      attr_accessor :uml_classes

      def initialize
        @uml_classes = []
      end

      def <<( uml_class )
        @uml_classes << uml_class
      end

      def compute_dependencies!
        @uml_classes.each { |c| c.compute_dependencies!( @uml_classes ) }
        self
      end
    end
  end
end
