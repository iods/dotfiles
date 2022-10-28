require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

def _h
  puts irb_history.join("\n")
end

def irb_history(count = nil)
  hist = Readline::HISTORY.to_a

  if count
    len = hist.length
    from = len - count
    from = 0 if from < 0
    puts "len: #{len}, count: #{count}, from: #{from}, hist.class: #{hist.class}, hist.length: #{hist.length}"

    hist[from..-1]
  else
    hist
  end
end

require 'securerandom'
require 'base64'





# -*- mode: ruby -*- vim:set ft=ruby:

ENV['HOME'] ||= ENV['USERPROFILE'] || File.dirname(__FILE__)

$LOAD_PATH.unshift(File.expand_path('~/.ruby/lib'), File.expand_path('~/.ruby'))
$LOAD_PATH.uniq!

%w(rubygems pry pry-editline awesome_print).each do |lib|
  begin
    require lib
  rescue LoadError
  end
end

(Pry.start; exit) if defined?(Pry)

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:LOAD_MODULES] |= %w(irb/completion stringio enumerator ostruct)
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = File.expand_path('~/.cache/history.rb')
