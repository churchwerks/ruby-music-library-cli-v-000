require 'pry'
require_relative '../config/environment.rb'
class Genre
  extend Concerns::Findable
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

  def self.find_by_name(name)
    self.all.detect{|item| item.name == name}
  end

  def self.find_or_create_by_name(genre)
    self.find_by_name(genre) || self.create(genre)
  end

  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end

  def songs
    @songs
  end

  def add_song(song)
    @songs << song unless @songs.include?(song)
    song.genre = self unless song.genre
  end

  def artists
    songs.collect {|item| item.artist }.uniq
  end
end
