module Umlify
  module Visitors
    class ToUML < SexpVisitor
      visitor_for :program do |sexp|
        puts "visting program"
        sexp.args.map { |s| s.accept( self ) }
        Umlify::UmlClasses::UmlDiagram.new
      end

      visitor_for :stmts_add do |sexp|
        sexp.args.map { |s| s.accept( self ) }
      end

      visitor_for :class do |sexp|
        puts "visiting class"

        name_sexp = sexp.find( :const_ref )
        name = name_sexp.accept( self ) if name_sexp

        super_sexp = sexp.find( :var_ref )
        super_name = super_sexp.accept( self ) if super_sexp

        body = sexp.find( :bodystmt ).walk do |arr|
          arr.accept( self ) if arr[0] == :@ident
        end

        UMLClass.new( name, super_name )
      end

      visitor_for :const_ref, :var_ref do |sexp|
        puts "visiting const_ref: #{sexp}"
        sexp.args.first.accept( self )
      end

      visitor_for :const, :ident do |sexp|
        puts "visiting const"
        sexp.args.first
      end
    end
  end
end
