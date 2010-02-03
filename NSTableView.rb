# NSTableView.rb
# TVRenamer
#
# Created by Bodaniel Jeanes on 3/02/10.
# Copyright 2010 Mocra. All rights reserved.

class NSTableView
	def [](column)
		tableColumnWithIdentifier(column)
	end
end
