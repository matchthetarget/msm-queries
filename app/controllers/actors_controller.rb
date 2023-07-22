class ActorsController < ApplicationController
  def index
    @actors = Actor.all.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @actor = Actor.where({:id => the_id }).at(0)
    
    render({ :template => "actor_templates/show" })
  end

  def create
    @actor = Actor.new
    @actor.name = params.fetch("query_name")
    @actor.dob = params.fetch("query_dob")
    @actor.bio = params.fetch("query_bio")
    @actor.image = params.fetch("query_image")

    if @actor.valid?
      @actor.save
      redirect_to("/actors", { :notice => "Actor created successfully." })
    else
      redirect_to("/actors", { :notice => "Actor failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @actor = Actor.where({ :id => the_id }).at(0)

    @actor.name = params.fetch("query_name")
    @actor.dob = params.fetch("query_dob")
    @actor.bio = params.fetch("query_bio")
    @actor.image = params.fetch("query_image")

    if @actor.valid?
      @actor.save
      redirect_to("/actor_templates/#{@actor.id}", { :notice => "Actor updated successfully."} )
    else
      redirect_to("/actor_templates/#{@actor.id}", { :alert => "Actor failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @actor = Actor.where({ :id => the_id }).at(0)

    @actor.destroy

    redirect_to("/actors", { :notice => "Actor deleted successfully."} )
  end
end
