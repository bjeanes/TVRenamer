# MainController.rb
# TVRenamer
#
# Created by Bodaniel Jeanes on 3/02/10.
# Copyright 2010 Mocra. All rights reserved.

class MainController < NSWindowController
  
  attr_accessor :open_folder_button, :file_list, :file_summary, :file_table, :recursive
  
  def recursive?
    recursive.state = NSOnState
  end
end