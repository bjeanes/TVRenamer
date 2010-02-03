# MainController.rb
# TVRenamer
#
# Created by Bodaniel Jeanes on 3/02/10.
# Copyright 2010 Mocra. All rights reserved.

require "pathname"

class MainController < NSWindowController
  ALLOWED_FILE_EXTENSIONS = %w(mov mkv avi mpg mpeg mp4 m4v ogm wmv)
  ALLOWED_FILE_EXT_REGEXP = /\.(#{ALLOWED_FILE_EXTENSIONS.join('|')})$/
  
  attr_accessor :open_folder_button, :file_list, :file_summary, :file_table, :recursive
  
  def open_folder_button_pressed(sender)
    result = open_dialog.runModalForDirectory("~/Movies", file: nil, types: ALLOWED_FILE_EXTENSIONS)
    if result == NSOKButton
      set_files(open_dialog.URLs.map { |u| Pathname.new(u.path) })
    end
  end
  
  private
  def open_dialog
    @dialog ||= begin
      d = NSOpenPanel.openPanel
      #d.delegate                = self
      d.canChooseFiles          = true
      d.canChooseDirectories    = true
      d.allowsMultipleSelection = true
      #d.allowedFileTypes        = ALLOWED_FILE_EXTENSIONS
      #d.directoryURL            = NSURL.fileURLWithPath("~/Movies")
      d
    end
  end
  
  def set_files(urls)
    file_list.clear
    
    urls.each do |url|
      url.find do |file|
        Find.prune if file.basename.to_s =~ /^\._/
      
        if file.directory?
          Find.prune unless recursive?
        else
          if file.to_s =~ ALLOWED_FILE_EXT_REGEXP
            file_list.push(file)
          end
        end       
      end
    end
    
    file_table.reloadData
    
    @file_summary.stringValue = "#{file_list.size} Entries"
  end
  
  def recursive?
    recursive.state = NSOnState
  end
end