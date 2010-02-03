# FileListController.rb
# TVRenamer
#
# Created by Bodaniel Jeanes on 3/02/10.
# Copyright 2010 Mocra. All rights reserved.

class FileTableController < NSController
	attr_accessor :file_table, :file_list
	
	# Data Source
	def numberOfRowsInTableView(table)
		if table == file_table
			file_list.size
		else
			0
		end
	end
	
	def tableView(table, objectValueForTableColumn: column, row: row)
		row  = file_list[row]
		path = row.path.to_s
		name = row.lastPathComponent.to_s

		case column
		when table["status"]
			""
		when table["original"]
			name
		when table["new"]
			name.gsub(/\./,' ')
		when table["path"]
			path
		else
			""
		end
	end
	
end