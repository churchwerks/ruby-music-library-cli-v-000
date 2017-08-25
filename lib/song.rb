require "pry"
class Song
  attr_accessor :name
  attr_reader :artist
  @@all = []

  def initialize(name, artist = nil)
    @name = name
    self.artist = artist if artist
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self) if artist
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
  end

  def self.new_by_name(song_name)
    song = self.create
    song.name = song_name
    song
  end

  def self.create_by_name(song_name)
    song = self.new_by_name(song_name)
    song
  end

  def self.find_by_name(song_name)
    self.all.detect {|item| item.name == song_name}
  end

  def self.find_or_create_by_name(song_name)
    self.find_by_name(song_name) || self.create_by_name(song_name)
  end

  def self.alphabetical
    self.all.sort_by { |item| item.name}
  end

  def self.new_from_filename(filename)
    filename = filename.gsub!(".mp3", "")
    filename = filename.split(" - ")
    artist_name = filename[0]
    song_name = filename[1]
    song = self.new
    song.name = song_name
    song.artist_name = artist_name
    song
  end

  def self.create_from_filename(filename)
    filename = filename.gsub!(".mp3", "")
    filename = filename.split(" - ")
    artist_name = filename[0]
    song_name = filename[1]
    song = self.create
    song.name = song_name
    song.artist_name = artist_name
    song
  end
end
