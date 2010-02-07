# Class_ext.rb
# TVRenamer
#
# Created by Bodaniel Jeanes on 7/02/10.
# Copyright 2010 Bodaniel Jeanes. All rights reserved.

class Class
  def delegate(*methods)
    options = methods.pop
    
    methods.each do |method|
      define_method(method) do |*args|
        send(options[:to]).send(method, *args)
      end
    end
  end
end