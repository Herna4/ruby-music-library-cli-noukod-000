class Song
  

  @@all = []
  attr_accessor :name
  attr_reader :artist, :genre

  def initialize(name, artist = "",genre = "")
    @name = name
    artist != ""? self.artist = artist : @artist = artist
    genre != ""? self.genre = genre : @genre = genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    all.clear
  end

  def save
    Song.all << self
  end

  def self.create(name)
    new(name).tap {|song| song.save}
  end

  def artist=(artist)
    @artist = artist
    artist.add_song self
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self if !genre.songs.include?(self)
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
    new_from_filename(filename).tap {|song| song.save}
  end
end
