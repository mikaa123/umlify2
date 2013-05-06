class Array
  def accept( visitor )
    visitor.visit self
  end

  def stop_at( op, &blk )
    return blk.call(self) if self[0] == op
    each { |e| e.stop_at( op, &blk ) if e.respond_to? :stop_at }
  end

  def walk( &blk )
    each { |e| e.walk( &blk ) if e.respond_to? :walk }
    blk.call(self) if blk
  end
end
