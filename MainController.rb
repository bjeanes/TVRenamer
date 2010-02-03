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
    if open_dialog.runModal == NSOKButton
      urls = open_dialog.URLs.map { |u| Pathname.new(u.path) }
      set_files(urls)
      @file_summary.stringValue = "#{urls.size} Entries"
    end
  end
  
  private
  def open_dialog
    @dialog ||= begin
      d = NSOpenPanel.openPanel
      d.delegate                = self
      d.canChooseFiles          = true
      d.canChooseDirectories    = true
      d.allowsMultipleSelection = true
      d.allowedFileTypes        = ALLOWED_FILE_EXTENSIONS
      d.directoryURL            = NSURL.fileURLWithPath("~/Movies")
      d
    end
  end
  
  def set_files(urls)
    urls = if recursive?
      expand_urls(urls)
    else
      urls.reject(&:directory?)
    end
  
    file_list.clear
    file_list.push(*urls)
    file_table.reloadData
  end
  
  def expand_urls(urls)
    urls.map do |url|
      if url.directory?
        expand_urls(url.children)
      else
        url
      end
    end.flatten
  end
  
  def recursive?
    recursive.state = NSOnState
  end
end