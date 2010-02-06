# MainController.rb
# TVRenamer
#
# Created by Bodaniel Jeanes on 3/02/10.
# Copyright 2010 Mocra. All rights reserved.

class MainController < NSWindowController
  attr_accessor :file_list

  def perform_rename(sender)
    file_list.arrangedObjects.each do |episode|
      Dir.chdir(episode.dirname) do
        episode.rename(episode.new_name)
      end
    end
  end
end