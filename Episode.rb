# Episode.rb
# TVRenamer
#
# Created by Bodaniel Jeanes on 5/02/10.
# Copyright 2010 Mocra. All rights reserved.

require "pathname"

class Episode < Pathname
  def path
    to_s
  end
  
  def original_name
    basename.to_s
  end
  
  def new_name
    @new_name ||= original_name.gsub(/(.)./, '\1')
  end
  
  def method_missing(method, *args, &block)
    "foo"
  end
end