require 'pry'

class MusicLibraryController
  attr_accessor :path, :song

  def initialize(path='./db/mp3s')
    @path=path
    imported= MusicImporter.new(path)
    imported.import
  end

  def call
    input = []
    while input != 'exit'
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.chomp

    case input
      when 'list songs'
        self.list_songs
      when 'list artists'
        self.list_artists
      when 'list genres'
        self.list_genres
      when 'list artists'
        self.list_artists
      when 'list artist'
        self.list_songs_by_artist
      when 'list genre'
        self.list_songs_by_genre
      when 'play song'
        self.play_song
      else
        "Type in a valid request please"
      end
    end
  end

  def list_songs
    song_list= Song.all.sort{|a, b| a.name <=> b.name}
    song_list.each_with_index do |song, index|
      puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    artist_list= Artist.all.sort{|a, b| a.name <=> b.name}
    artist_list.each_with_index do |artist, index|
      puts "#{index+1}. #{artist.name}"
    end
  end

  def list_genres
    genres_list= Genre.all.sort{|a, b| a.name <=> b.name}
    genres_list.each_with_index do |genres, index|
      puts "#{index+1}. #{genres.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    if artist = Artist.find_by_name(input)
      artist.songs.sort { |a,b| a.name <=> b.name }.each.with_index(1) do |song, index|
        puts "#{index}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    if genre = Genre.find_by_name(input)
      genre.songs.sort { |a,b| a.name <=> b.name }.each.with_index(1) do |song, index|
        puts "#{index}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.chomp.to_i

    if input > 0 && input <= Song.all.length
      song_list = Song.all.sort{|a, b| a.name <=> b.name}
      song = song_list[input-1]
      puts "Playing #{song.name} by #{song.artist.name}"
    end
  end
end
