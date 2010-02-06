# FileList.rb
# TVRenamer
#
# Created by Bodaniel Jeanes on 5/02/10.
# Copyright 2010 Mocra. All rights reserved.


class FileList < NSArrayController
  FILE_EXTENSIONS = %w(mov mkv avi mpg mpeg mp4 m4v ogm wmv)
  FILE_EXT_REGEXP = /\.(#{FILE_EXTENSIONS.join('|')})$/

  def clear(sender)
    removeObjects(arrangedObjects)
  end
  
  def add(sender)
    open do |dialog|
      dialog.URLs.each do |url|
        url.to_pathname.find do |file|          
          if file.to_s =~ FILE_EXT_REGEXP && !file.directory?
            Find.prune if file.basename.to_s =~ /^\./
            addObject(file.to_episode)
          end
        end
      end
    end
  end

  private
  def open(&block)
    with(NSOpenPanel.openPanel) do |dialog|
      dialog.canChooseFiles          = true
      dialog.canChooseDirectories    = true
      dialog.allowsMultipleSelection = true

      result = dialog.runModalForDirectory "~/Movies", 
                                      file: nil, 
                                      types: FILE_EXTENSIONS

      return block.call(dialog) if result == NSOKButton
    end
  end
end