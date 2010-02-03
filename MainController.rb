# MainController.rb
# TVRenamer
#
# Created by Bodaniel Jeanes on 3/02/10.
# Copyright 2010 Mocra. All rights reserved.

require "pathname"

class MainController < NSWindowController
  ALLOWED_FILE_EXTENSIONS = %w(mov mkv avi mpg mpeg mp4 m4v ogm wmv)
  
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
    urls = if recursive?
      expand_urls(urls).flatten.compact
    else
      urls.reject(&:directory?)
    end
  
    file_list.clear
    file_list.push(*urls)
    file_table.reloadData
    
    @file_summary.stringValue = "#{urls.size} Entries"
  end
  
  # TODO: Limit the number of files or depth to
  #       a reasonable number as this is a recursive
  #       method and could get out of hand
  def expand_urls(urls)
    urls.map do |url|
      if url.directory?
        expand_urls(url.children, depth + 1) if depth <= 5
      elsif ALLOWED_FILE_EXTENSIONS.include? url.extname.gsub(/\./,'')
        url
      else
        nil
      end
    end
  end
  
  def recursive?
    recursive.state = NSOnState
  end
end