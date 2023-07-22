class MoviesController < ApplicationController
  def index
    @movies = Movie.all.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @movie = Movie.find(the_id)

    render({ :template => "movie_templates/show" })
  end

  def create
    @movie = Movie.new
    @movie.title = params.fetch("query_title")
    @movie.year = params.fetch("query_year")
    @movie.duration = params.fetch("query_duration")
    @movie.description = params.fetch("query_description")
    @movie.image = params.fetch("query_image")
    @movie.director_id = params.fetch("query_director_id")

    if @movie.valid?
      @movie.save
      redirect_to("/movies", { :notice => "Movie created successfully." })
    else
      redirect_to("/movies", { :notice => "Movie failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @movie = Movie.find(the_id)

    @movie.title = params.fetch("query_title")
    @movie.year = params.fetch("query_year")
    @movie.duration = params.fetch("query_duration")
    @movie.description = params.fetch("query_description")
    @movie.image = params.fetch("query_image")
    @movie.director_id = params.fetch("query_director_id")

    if @movie.valid?
      @movie.save
      redirect_to("/movie_templates/#{@movie.id}", { :notice => "Movie updated successfully."} )
    else
      redirect_to("/movie_templates/#{@movie.id}", { :alert => "Movie failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @movie = Movie.find(the_id)

    @movie.destroy

    redirect_to("/movies", { :notice => "Movie deleted successfully."} )
  end
end
