require 'nanoc-sprockets-filter'

include Nanoc::Helpers::Rendering
include Nanoc::Helpers::Capturing
include Nanoc::Helpers::Sprockets

def wines
  @wines ||= items.select {|item| item.identifier =~ /^\/wines/ }.reject {|w| w[:archive] }.sort {|a, b| a[:order] <=> b[:order] }
end

def wine_image_path(item, options = {})
  wine_name = item.identifier.match(/([^\/]+)\/$/)[1]
  rep_name  = options.delete(:rep)

  begin
    image_item = items.find {|i| i.identifier =~ /images\/wine_#{wine_name}\/$/ }.rep_named(rep_name || :default).item
  rescue
    raise "Cannot find image for wine item `#{item.identifier}` and rep `#{rep_name || :default}`"
  end

  image_path image_item, :rep => rep_name
end

def wine_box_sizes
  box_sizes ||= begin
    box_sizes = {}

    wines.map {|wine| wine[:box_size] }.uniq.compact.each_with_index do |box_size, index|
      box_sizes[box_size] = index + 1
    end

    box_sizes
  end
end
