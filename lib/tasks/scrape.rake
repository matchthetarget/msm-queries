task(:scrape) do
  require 'mechanize'
  require 'date'
  mechanize = Mechanize.new
  url = "https://www.imdb.com/chart/top/?ref_=nv_mv_250"
  page = mechanize.get(url)

  movie_attr = page.css("#main a")
  imdb_ids = Array.new
  movie_ids = Array.new

  movie_attr.each do |movie|
    link = movie.attr('href')
    if link != nil
      imdb_ids.push(link.split("/")[2])
    end
  end


  Tmdb::Api.key(ENV.fetch("TMDB_KEY"))

  imdb_ids.uniq.each do |imdb_id|
    movie_info = Tmdb::Find.movie(imdb_id, external_source: 'imdb_id')[0]
    if !movie_info.nil?
      movie_ids.push(movie_info.id)
    end
  end

  movie_ids = movie_ids[0..24]

  movies = Array.new
  directors = Array.new

  movie_ids.each do |movie_id|
    movies.push(Tmdb::Movie.detail(movie_id))
    directors.push(Tmdb::Movie.director(movie_id)[0])
  end

  directors = directors.uniq

  director_details = Array.new

  directors.each do |director|
    details = Hash.new
    director_obj = Tmdb::Person.detail(director.id)
    details.store(:id, director.id)
    details.store(:name, director_obj.name)
    if director_obj.birthday != nil
      details.store(:dob, director_obj.birthday)
    else
      details.store(:dob, nil)
    end
    details.store(:bio, director_obj.biography)
    if director_obj.profile_path != nil
      details.store(:image, "https://image.tmdb.org/t/p/w500" + director_obj.profile_path)
    else
      details.store(:image, src="https://robohash.org/" + director_obj.name + "?set=set3")
    end
    details.store(:created_at, "2015-08-12 17:20:11")
    details.store(:updated_at, "2015-08-12 17:20:11")
    director_details.push(details)
  end

  movie_details = Array.new
  character_details = Array.new
  actor_details = Array.new

  require "date"
  movies.each do |movie|
    details = Hash.new
    details.store(:id, movie_details.count + 1)
    details.store(:title, movie.title)
    details.store(:year, Date.parse(movie.release_date).year)
    details.store(:duration, movie.runtime)
    details.store(:description, movie.overview)
    details.store(:image, "https://image.tmdb.org/t/p/w500" + movie.poster_path)
    director_id = Tmdb::Movie.director(movie.id)[0].id
    details.store(:director_id, director_id)
    details.store(:created_at, "2015-08-12 17:20:11")
    details.store(:updated_at, "2015-08-12 17:20:11")
    movie_details.push(details)
    cast = Tmdb::Movie.cast(movie.id)
    cast.each do |character|
      character_hash = Hash.new
      character_hash.store(:id, character_details.count + 1)
      character_hash.store(:name, character.character)
      character_hash.store(:movie_id, details.fetch(:id))
      character_hash.store(:created_at, "2015-08-12 17:20:11")
      character_hash.store(:updated_at, "2015-08-12 17:20:11")
      played_by = Tmdb::Search.person(character.name)
      if played_by.results[0] != nil
        actor_id =  played_by.results[0].id
        character_hash.store(:actor_id, actor_id)
        actor_hash = Hash.new
        actor_obj = Tmdb::Person.detail(actor_id)
        actor_hash.store(:id, actor_id)
        actor_hash.store(:name, actor_obj.name)
        actor_hash.store(:dob, actor_obj.birthday)
        actor_hash.store(:bio, actor_obj.biography)
        if actor_obj.profile_path != nil
          actor_hash.store(:image, "https://image.tmdb.org/t/p/w500" + actor_obj.profile_path)
        else
          actor_hash.store(:image, src="https://robohash.org/" + actor_obj.name + "?set=set3")
        end
        actor_hash.store(:created_at, "2015-08-12 17:20:11")
        actor_hash.store(:updated_at, "2015-08-12 17:20:11")
        actor_details.push(actor_hash)
      else
        character_hash.store(:actor_id, nil)
      end
      character_details.push(character_hash)
    end
  end

  actor_details = actor_details.uniq
  movie_details = movie_details.uniq
  director_details = director_details.uniq
  character_details = character_details.uniq

  file_path = "lib/tasks"

  file_contents = <<~HEREDOC
    desc "Hydrate the database with some sample data to look at so that developing is easier"
    task({ :sample_data => :environment}) do
      Director.delete_all
      director_values = #{director_details}
      Director.insert_all!(director_values)
      puts "There are #{director_details.count} directors in the database"
      Movie.delete_all
      movie_values = #{movie_details}
      Movie.insert_all!(movie_values)
      puts "There are #{movie_details.count} movies in the database"
      Actor.delete_all
      actor_values = #{actor_details}
      Actor.insert_all!(actor_values)
      puts "There are #{actor_details.count} actors in the database"
      Character.delete_all
      character_values = #{character_details}
      Character.insert_all!(character_values)
      puts "There are #{character_details.count} characters in the database"



    end
  HEREDOC

File.write("#{file_path}/dev.rake", "#{file_contents}")

end
