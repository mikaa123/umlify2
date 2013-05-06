module Umlify
  module UmlClasses
    class UmlClass
      attr_accessor :name, :super, :methods, :constants, :dependencies

      def initialize( opts )
        @name = opts[ :name ]
        @super = opts[ :super ]
        @methods = opts[ :methods ] || []
        @constants = opts[ :constants ] || []
        @dependencies = []
      end

      def compute_dependencies!( uml_classes )
        @constants.each do |cst|
          if uml_class = uml_classes.find { |c| c.name == cst }
            @dependencies << uml_class
          end
        end
      end
    end
  end
end
