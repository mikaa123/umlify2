module Umlify
  module Visitors
    class SexpVisitor
      def self.visitor_for( *tokens, &block )
        tokens.each do |token|
          define_method(:"visit_#{token}", block)
        end
      end

      def visit( arr )
        begin
          sexp = SExp.new( arr )
          send( "visit_#{ sexp.op }", sexp )
        rescue SExpError => error
        rescue StandardError => error
        end
      end
    end
  end
end
