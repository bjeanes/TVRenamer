# TVParser.rb
# TVRenamer
#
# Created by Bodaniel Jeanes on 7/02/10.
# Copyright 2010 Mocra. All rights reserved.

module TVParser
  Episode = Struct.new(:series, :season, :number)
  
  PATTERN = /^(.+?)(?:\s?[-\.]\s?)?\s*\[?s?(\d\d?)\s?\.?\s?[ex-]?\s?(?:(\d\d)(?:\s?[,-]\s?[ex]?(\d\d))?)\]?\s?.*$/i

  def self.parse(filename)
    # House.S04E13.HDTV.XviD-XOR.avi
    # my.name.is.earl.s03e07-e08.hdtv.xvid-xor.[VTV].avi
    # My_Name_Is_Earl.3x17.No_Heads_And_A_Duffel_Bag.HDTV_XviD-FoV.[VTV].avi
    # My Name Is Earl - 3x04.avi
    # MythBusters - S04E01 - Newspaper Crossbow.avi
    # my.name.is.earl.305.hdtv-lol.[VTV].avi
    if filename.to_s =~ PATTERN
      season = $2.to_i
      number = $4 ? ($3.to_i)..($4.to_i) : $3.to_i
      series = titleize($1.gsub(/[\._]/, ' '))
      Episode.new(series, season, number) 
    else
      nil
    end
  end
  
  def self.titleize(string)
    string.strip.gsub(/\b\w/) { $&.upcase }
  end
end