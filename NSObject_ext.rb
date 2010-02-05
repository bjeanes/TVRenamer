# NSObject_ext.rb
# TVRenamer
#
# Created by Bodaniel Jeanes on 5/02/10.
# Copyright 2010 Mocra. All rights reserved.

class NSObject
  def returning(value, &block)
    block.call(value)
    value
  end
  
  alias with returning
end