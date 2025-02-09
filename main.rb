#!/usr/bin/env ruby

require "bundler/inline"
gemfile do
  source "https://rubygems.org"
  gem "sqlite3"
  gem "addressable"
end

require "erb"
require "uri"

DATABASE_PATH = File.join(Dir.home, "Library/Containers/com.apple.Safari/Data/Library/Safari/CloudTabs.db")

@database = SQLite3::Database.new(DATABASE_PATH)
@database.results_as_hash = true

unique_hosts = {}

tabs = @database.execute("SELECT title, url, last_viewed_time FROM cloud_tabs ORDER BY last_viewed_time DESC")
tabs.each do |t|
  t["host"] = Addressable::URI.parse(t["url"]).host.gsub(/^www\./, "")

  unique_hosts[t["host"]] ||= 0
  unique_hosts[t["host"]] += 1
end

unique_hosts = unique_hosts
  .keep_if { |host, count| count >= 2 }
  .sort_by { |host, count| count }
  .reverse

MAX_URL_LENGTH = 100
def truncate_url(url)
  return url unless url.length > MAX_URL_LENGTH
  "#{url[0..MAX_URL_LENGTH]}..."
end

template = ERB.new File.read("template.html.erb")
html_output = template.result(binding)

File.write("output.html", html_output)
# `open output.html`
