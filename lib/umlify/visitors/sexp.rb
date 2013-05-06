module Umlify
  module Visitors
    class SExpError < RuntimeError; end

    class SExp < Struct.new( :op, :args )

      # arr is a Ripper S-Expression.
      def initialize( arr )
        if arr.nil? || !arr.is_a?( Array ) || arr.empty? || arr[0].is_a?( Array )
          raise SExpError, "Not valid S-expression" 
        end
        super( arr.shift.to_s.gsub( /@/, '' ).to_sym, arr )
      end

      # Looks up the arg list to return the first the first
      # s-expression with an op code of `op`.
      def find( op )
        args.find { |s| s[0] == op if s.respond_to? :[] } || []
      end
    end
  end
end
