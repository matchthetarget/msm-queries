class DirectorsController < ApplicationController
  def index
    @directors = Director.all.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @director = Director.find(the_id)
    @filmography = Movie.where({ :director_id => @director.id })

    render({ :template => "director_templates/show" })
  end

  def create
    @director = Director.new
    @director.name = params.fetch("query_name")
    @director.dob = params.fetch("query_dob")
    @director.bio = params.fetch("query_bio")
    @director.image = params.fetch("query_image")

    if @director.valid?
      @director.save
      redirect_to("/directors", { :notice => "Director created successfully." })
    else
      redirect_to("/directors", { :notice => "Director failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @director = Director.find(the_id)

    @director.name = params.fetch("query_name")
    @director.dob = params.fetch("query_dob")
    @director.bio = params.fetch("query_bio")
    @director.image = params.fetch("query_image")

    if @director.valid?
      @director.save
      redirect_to("/directors/#{@director.id}", { :notice => "Director updated successfully."} )
    else
      redirect_to("/directors/#{@director.id}", { :alert => "Director failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @director = Director.find(the_id)

    @director.destroy

    redirect_to("/directors", { :notice => "Director deleted successfully."} )
  end

  def max_dob
    @youngest = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc }).
      at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    @eldest = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc }).
      at(0)

    render({ :template => "director_templates/eldest" })
  end
end
