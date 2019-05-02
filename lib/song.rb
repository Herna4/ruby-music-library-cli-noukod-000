require 'pry'

class Song
  extend Concerns::Findable
  attr_accessor :name, :artist, :genre

  @@all = []

  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist = artist if artist != nil
    self.genre = genre if genre != nil
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
    self
  end

  def self.create(name)
    song = self.new(name)
    song.save
    song
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.find_by_name(name)
    all.detect {|song| song.name == name}
 end

 def self.find_or_create_by_name(name)
   find_by_name name or create name
 end

  def self.new_from_filename(filename)
    artist_name, song_name, genre = filename.gsub(".mp3","").split(" - ")
    new(song_name,Artist.find_or_create_by_name(artist_name),Genre.find_or_create_by_name(genre))
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).save
  end
end
