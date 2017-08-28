require 'pry'
require_relative '../config/environment.rb'
class Artist
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.find_by_name(name)
    self.all.detect{|item| item.name == name}
  end


  def find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end

  def self.all
    @@all
  end

  def self.destroy_all
    all.clear
  end

  def save
    self.class.all << self
  end

  def self.create(name)
    artist = new(name)
    artist.save
    artist

    # Or, as a one-liner:
    # new(name).tap{ |a| a.save }
  end

  def add_song(song)
    song.artist = self unless song.artist
    songs << song unless songs.include?(song)
  end

  def genres
    songs.collect{ |s| s.genre }.uniq
  end
end
