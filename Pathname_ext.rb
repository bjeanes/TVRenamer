# Pathname.rb
# TVRenamer
#
# Created by Bodaniel Jeanes on 5/02/10.
# Copyright 2010 Mocra. All rights reserved.

require "pathname"

class Pathname
  def to_episode
    Episode.new(self)
  end
end