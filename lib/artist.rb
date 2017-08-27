require 'pry'
require_relative '../config/environment.rb'
class Artist
  #extend Memorable::ClassMethods
  #include Memorable::InstanceMethods
  extend Concerns::Findable
  #include Paramable::InstanceMethods
  attr_accessor :name, :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    artist = Artist.new(name)
    artist.save
    artist
  end

  def add_song(song)
    @songs << song unless @songs.include?(song)
    song.artist = self unless song.artist
  end

  def genres
    songs.collect {|item| item.genre }.uniq
  end

  def self.create_by_name(artist_name)
    artist = self.new(artist_name)
    artist.save
    artist
  end

  def self.find_by_name(artist_name)
    self.all.detect {|item| item.name == artist_name}
  end

  def self.find_or_create_by_name(artist_name)
    self.find_by_name(artist_name) || self.create_by_name(artist_name)
  end

  def print_songs
    self.songs.each { |title| puts "#{title.name}" }
  end
end
