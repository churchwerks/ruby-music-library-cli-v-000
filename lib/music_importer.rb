require "pry"
require_relative '../config/environment.rb'
class MusicImporter
  extend Concerns::Findable
  attr_accessor :path
  @@all = []

  def initialize(path)
    @path = path
  end

  def files
    Dir.foreach(self.path) do |filename|
      filename.end_with?(".mp3") ? @@all << filename : nil
    end
    @@all
  end

  def import
    #binding.pry
    @@all.each {|file_name| Song.create_from_filename(file_name) }
  end
end
