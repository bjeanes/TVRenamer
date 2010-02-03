# MainController.rb
# TVRenamer
#
# Created by Bodaniel Jeanes on 3/02/10.
# Copyright 2010 Mocra. All rights reserved.

class MainController < NSWindowController
  attr_accessor :open_folder_button, :file_list, :file_summary, :file_table
  
  def open_folder_button_pressed(sender)
    dialog = NSOpenPanel.openPanel
    dialog.delegate                = self
    dialog.canChooseFiles          = true
    dialog.canChooseDirectories    = true
    dialog.allowsMultipleSelection = true
    
    response = dialog.runModalForDirectory("~/Movies", file: nil)
    
    if response == NSOKButton
      urls = dialog.URLs

      file_list.clear
      file_list.push(*urls)
      
      file_table.reloadData
      
      @file_summary.stringValue = "#{urls.size} Entries"
    end
  end
end