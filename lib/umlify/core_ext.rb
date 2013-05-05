class Array
  def accept( visitor )
    visitor.visit self
  end

  # def walk( &blk )
  #   each { |e| e.walk( &blk ) if e.respond_to? :walk }
  #   blk.call(self) if blk
  # end
end
