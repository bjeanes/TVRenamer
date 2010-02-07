# NSURL_ext.rb
# TVRenamer
#
# Created by Bodaniel Jeanes on 5/02/10.
# Copyright 2010 Bodaniel Jeanes. All rights reserved.

require "pathname"

class NSURL
  def to_pathname
    Pathname.new(path)
  end
end