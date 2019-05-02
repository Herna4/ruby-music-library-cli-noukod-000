class MusicLibraryController

  def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
  end

  def call
    user_input = ""

    until option == "exit" do
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"

      option = gets.strip

      case option
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end
    end
  end

  def list_songs
    Song.all.sort do |song1, song2|
      song1.name <=> song2.name
    end.each.with_index(1) {|song, index| puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
  end

  def list_artists
    Artist.all.sort do |artist1, artist2|
      artist1.name <=> artist2.name
    end.each.with_index(1) {|artist, index| puts "#{index}. #{artist.name}"}
  end

  def list_genres
    Genre.all.sort do |genre1, genre2|
      genre1.name <=> genre2.name
    end.each.with_index(1) {|genre, index| puts "#{index}. #{genre.name}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input_name = gets.strip

    if artist = Artist.find_by_name(input_name)
      artist.songs.sort do |s1, s2|
        s1.name <=> s2.name
      end.each.with_index(1) {|song, i| puts "#{i}. #{song.name} - #{song.genre.name}"}
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input_genre = gets.strip

    if genre = Genre.find_by_name(input_genre)
      genre.songs.sort do |s1, s2|
        s1.name <=> s2.name
      end.each.with_index(1) {|song, i| puts "#{i}. #{song.artist.name} - #{song.name}"}
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i

    if (1..Song.all.size).include?(input)
      Song.all.sort {|song1, song2| song1.name <=> song2.name}[(input-1)].tap {|song| puts "Playing #{song.name} by #{song.artist.name}"}
    end

  end

end
