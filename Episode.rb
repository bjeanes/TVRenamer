# Episode.rb
# TVRenamer
#
# Created by Bodaniel Jeanes on 5/02/10.
# Copyright 2010 Mocra. All rights reserved.

require "pathname"

class Episode < Pathname
  delegate :season, :series, :number, :to => :parsed_info

  def path
    to_s
  end
  
  def original_name
    basename.to_s
  end
  
  def status
    renamed? ? "✔" : ""
  end
  
  def new_name
    @new_name ||= begin
      filename_format % [series, season, number, name]
    rescue NoMethodError => e
      original_name
    end
  end

  def rename
    Dir.chdir(dirname) do
      super(new_name)
    end
  end

  def renamed?
    false
  end
  
  # Episode Name
  def name
    
  end
  
  private
    def parsed_info
      @parsed_info ||= unless parsed?
        parsed!
        TVParser.parse(original_name)
      end
    end
    
    def filename_format
      if name?
        "%s - %sx%s - %s#{extname}"
      else
        "%s - %sx%s#{extname}"
      end
    end
    
    def name?
      !name.blank?
    end
    
    def parsed!
      @parsed = true
    end
    
    def parsed?
      !!@parsed
    end
    
    def can_parse?
      !parsed_info.nil?
    end
end