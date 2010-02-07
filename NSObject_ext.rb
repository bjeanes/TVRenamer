# NSObject_ext.rb
# TVRenamer
#
# Created by Bodaniel Jeanes on 5/02/10.
# Copyright 2010 Bodaniel Jeanes. All rights reserved.

class NSObject
  def returning(value, &block)
    block.call(value)
    value
  end
  
  def blank?
    nil? || self == ""
  end
  
  alias with returning
end