# Pathname_ext.rb
# TVRenamer
#
# Created by Bodaniel Jeanes on 5/02/10.
# Copyright 2010 Bodaniel Jeanes. All rights reserved.

require "pathname"

class Pathname
  def to_episode
    Episode.new(self)
  end
end