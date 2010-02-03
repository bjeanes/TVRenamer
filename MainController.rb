# MainController.rb
# TVRenamer
#
# Created by Bodaniel Jeanes on 3/02/10.
# Copyright 2010 Mocra. All rights reserved.

class MainController < NSWindowController
	attr_writer :open_folder_button, :urls, :file_summary
	
	def open_folder_button_pressed(sender)
		dialog = NSOpenPanel.openPanel
		dialog.canChooseFiles		   = true
		dialog.canChooseDirectories	   = true
		dialog.allowsMultipleSelection = true
		
		response = dialog.runModalForDirectory("~/Movies", file: nil)
		
		if response == NSOKButton
			@urls		 = dialog.URLs
			files		 = @urls.map(&:lastPathComponent)
			self.summary = files.join(', ')
		end
	end
	
	def summary=(summary)
		self.file_summary.stringValue = summary
	end
end