require "rails_helper"

describe "/actors" do
  it "lists the names of each Actor record in the Actor table", points: 1 do
    
    ashley_johnson = Actor.new
    ashley_johnson.name = "Ashley Johnson"
    ashley_johnson.dob = 28.years.ago
    ashley_johnson.image = ""
    ashley_johnson.save
    
    gugu = Actor.new
    gugu.name = "Gugu Mbatha-Raw"
    gugu.dob = 38.years.ago
    gugu.image = ""
    gugu.save
    
    idris = Actor.new
    idris.name = "Idris Elba"
    idris.dob = 58.years.ago
    idris.image = ""
    idris.save

    visit "/actors"

    expect(page).to have_text(ashley_johnson.name),
      "Expected page to have the name, 'Ashley Johnson'"
    
    expect(page).to have_text(gugu.name),
      "Expected page to have the name, '#{gugu.name}'"
    
    expect(page).to have_text(idris.name),
      "Expected page to have the name, '#{idris.name}'"
  end
end

describe "/actors" do
  it "has a 'Show details' link to the details page of each Actor", points: 1 do
    
    ashley_johnson = Actor.new
    ashley_johnson.name = "Ashley Johnson"
    ashley_johnson.dob = 28.years.ago
    ashley_johnson.image = ""
    ashley_johnson.save
    
    gugu = Actor.new
    gugu.name = "Gugu Mbatha-Raw"
    gugu.dob = 38.years.ago
    gugu.image = ""
    gugu.save
    
    idris = Actor.new
    idris.name = "Idris Elba"
    idris.dob = 58.years.ago
    idris.image = ""
    idris.save

    visit "/actors"

    expect(page).to have_tag("a", :with => { :href => "/actors/#{ashley_johnson.id}" }, :text => /Show\s+details/i),
      "Expected page to have the a link with the text 'Show details' and an href of '/actors/#{ashley_johnson.id}'"

    expect(page).to have_tag("a", :with => { :href => "/actors/#{gugu.id}" }, :text => /Show\s+details/i),
      "Expected page to have the a link with the text 'Show details' and an href of '/actors/#{gugu.id}'"

    expect(page).to have_tag("a", :with => { :href => "/actors/#{idris.id}" }, :text => /Show\s+details/i),
      "Expected page to have the a link with the text 'Show details' and an href of '/actors/#{idris.id}'"

  end
end

describe "/actors/ACTOR ID]" do
  it "displays the name of the Actor record", points: 1 do
    
    gugu = Actor.new
    gugu.name = "Gugu Mbatha-Raw"
    gugu.dob = 38.years.ago
    gugu.image = ""
    gugu.save

    visit "/actors/#{gugu.id}"

    expect(page).to have_text(gugu.name),
      "Expected page to have the name, '#{gugu.name}'"
      
  end
end

describe "/actors/ACTOR ID]" do
  it "displays the dob of the Actor record", points: 1 do
    
    ashley_johnson = Actor.new
    ashley_johnson.name = "Ashley Johnson"
    ashley_johnson.dob = 28.years.ago
    ashley_johnson.image = ""
    ashley_johnson.save

    visit "/actors/#{ashley_johnson.id}"

    expect(page).to have_text(ashley_johnson.dob),
      "Expected page to have the text, '#{ashley_johnson.dob}'"

  end
end

describe "/actors/ACTOR ID]" do
  it "displays the names of every Character the Actor has played", points: 1 do
    
    ashley_johnson = Actor.new
    ashley_johnson.name = "Ashley Johnson"
    ashley_johnson.dob = 28.years.ago
    ashley_johnson.image = ""
    ashley_johnson.save

    director = Director.new
    director.name = "Matthew Mercer"
    director.dob = 36.years.ago
    director.image = ""
    director.save

    infinity_train = Movie.new
    infinity_train.title = "Infinity Train"
    infinity_train.description = "Train infinite."
    infinity_train.year = 2020
    infinity_train.duration = 96
    infinity_train.director_id = director.id
    infinity_train.save

    tulip = Character.new
    tulip.name = "Tulip"
    tulip.actor_id = ashley_johnson.id
    tulip.movie_id = infinity_train.id
    tulip.save

    mt = Character.new
    mt.name = "Mirror Tulip"
    mt.actor_id = ashley_johnson.id
    mt.movie_id = infinity_train.id
    mt.save

    visit "/actors/#{ashley_johnson.id}"

    expect(page).to have_text(tulip.name),
      "Expected page to have the text, '#{tulip.name}'"

    expect(page).to have_text(mt.name),
      "Expected page to have the text, '#{mt.name}'"

  end
end

describe "/actors/ACTOR ID]" do
  it "displays the names of the Directors of each Movie the Actor has starred in", points: 1 do
    
    ashley_johnson = Actor.new
    ashley_johnson.name = "Ashley Johnson"
    ashley_johnson.dob = 28.years.ago
    ashley_johnson.image = ""
    ashley_johnson.save

    director = Director.new
    director.name = "Matthew Mercer"
    director.dob = 36.years.ago
    director.image = ""
    director.save

    other_director = Director.new
    other_director.name = "Cameron Diaz"
    other_director.dob = 38.years.ago
    other_director.image = ""
    other_director.save

    infinity_train = Movie.new
    infinity_train.title = "Infinity Train"
    infinity_train.description = "Train infinite."
    infinity_train.year = 2020
    infinity_train.duration = 96
    infinity_train.director_id = director.id
    infinity_train.save

    tulip = Character.new
    tulip.name = "Tulip"
    tulip.actor_id = ashley_johnson.id
    tulip.movie_id = infinity_train.id
    tulip.save

    deep_impact = Movie.new
    deep_impact.title = "Deep Impact"
    deep_impact.description = "It's like evangelion."
    deep_impact.year = 1999
    deep_impact.duration = 106
    deep_impact.director_id = other_director.id
    deep_impact.save

    mt = Character.new
    mt.name = "Mirror Tulip"
    mt.actor_id = ashley_johnson.id
    mt.movie_id = infinity_train.id
    mt.save

    ashley = Character.new
    ashley.name = "Ashley"
    ashley.actor_id = ashley_johnson.id
    ashley.movie_id = deep_impact.id
    ashley.save

    visit "/actors/#{ashley_johnson.id}"

    expect(page).to have_text(director.name)

    expect(page).to have_text(other_director.name)#,
      # "Expected page to have the text, '#{other_director.name}'"

  end
end
