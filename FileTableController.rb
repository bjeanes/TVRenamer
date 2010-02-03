# FileListController.rb
# TVRenamer
#
# Created by Bodaniel Jeanes on 3/02/10.
# Copyright 2010 Mocra. All rights reserved.

class FileTableController < NSController
	attr_accessor :file_table, :file_list
	
	# Data Source
	def numberOfRowsInTableView(table)
		file_list.size
	end
	
	def tableView(table, objectValueForTableColumn: column, row: row)
		row  = file_list[row]
		path = row.path.to_s
		name = row.lastPathComponent.to_s

		case column.identifier
			when "original" then name
			when "new"		then name.gsub(/\./,' ')
			when "path"		then path
		end
	end
	
end