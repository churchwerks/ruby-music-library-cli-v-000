require 'pry'
require_relative '../config/environment.rb'
class Song
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    #binding.pry
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def artist=(artist)
    @artist = artist
    #binding.pry
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    #binding.pry
    genre.add_song(self)
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
    #binding.pry
  end

  def self.find_by_name(song_name)
    self.all.detect {|item| item.name == song_name}
  end

  def self.find_or_create_by_name(song_name)
    self.find_by_name(song_name) || self.create(song_name)
  end

  def self.alphabetical
    self.all.sort_by { |item| item.name}
  end

  def self.new_from_filename(filename)
    filename = filename.gsub!(".mp3", "")
    filename = filename.split(" - ")
    artist_name = filename[0]
    song_name = filename[1]
    genre_name = filename[2]
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    #binding.pry
    song = self.new(song_name, artist, genre)
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).tap{ |s| s.save }
  end
end
