require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'
require 'cgi'


source  = "http://feeds.urbandictionary.com/UrbanWordOfTheDay"

content = ""

open(source) do |s| content = s.read end
rss = RSS::Parser.parse(content, false)          


# Grab the title and description, striping out html tags
word        = rss.items[0].title;
definition = CGI.unescapeHTML(rss.items[0].description).gsub(/&lt;\/?[^&gt;]*&gt;/, "")

