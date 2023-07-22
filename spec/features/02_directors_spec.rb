require "rails_helper"

describe "/directors" do
  it "lists the names of each Director record in the database", points: 1 do
    director = Director.new
    director.name = "Travis McElroy"
    director.dob = 38.years.ago
    director.image = ""
    director.save

    other_director = Director.new
    other_director.name = "Trina Kayetti"
    other_director.dob = 30.years.ago
    other_director.image = ""
    other_director.save

    iris_roy = Director.new
    iris_roy.name = "Iris Roy"
    iris_roy.dob = 32.years.ago
    iris_roy.image = ""
    iris_roy.save

    visit "/directors"

    expect(page).to have_text(director.name),
      "Expected page to have the name, '#{director.name}'"
    
    expect(page).to have_text(other_director.name),
      "Expected page to have the name, '#{other_director.name}'"
    
    expect(page).to have_text(iris_roy.name),
      "Expected page to have the name, '#{iris_roy.name}'"
  end
end

describe "/directors" do
  it "has a 'Show details' link to the details page of each director", points: 1 do
    director = Director.new
    director.name = "Travis McElroy"
    director.dob = 38.years.ago
    director.image = ""
    director.save

    other_director = Director.new
    other_director.name = "Trina Kayetti"
    other_director.dob = 30.years.ago
    other_director.image = ""
    other_director.save

    iris_roy = Director.new
    iris_roy.name = "Iris Roy"
    iris_roy.dob = 32.years.ago
    iris_roy.image = ""
    iris_roy.save

    visit "/directors"

    expect(page).to have_tag("a", :with => { :href => "/directors/#{director.id}" }, :text => /Show\s+details/i),
      "Expected page to have the a link with the text 'Show details' and an href of '/directors/#{director.id}'"

    expect(page).to have_tag("a", :with => { :href => "/directors/#{other_director.id}" }, :text => /Show\s+details/i),
      "Expected page to have the a link with the text 'Show details' and an href of '/directors/#{other_director.id}'"
    
    expect(page).to have_tag("a", :with => { :href => "/directors/#{iris_roy.id}" }, :text => /Show\s+details/i),
      "Expected page to have the a link with the text 'Show details' and an href of '/directors/#{iris_roy.id}'"

  end
end


describe "/directors/[DIRECTOR ID]" do
  it "displays the name of a specified Director record", points: 1 do
    director = Director.new
    director.name = "Travis McElroy"
    director.dob = 38.years.ago
    director.image = ""
    director.save

    iris_roy = Director.new
    iris_roy.name = "Iris Roy"
    iris_roy.dob = 32.years.ago
    iris_roy.image = ""
    iris_roy.save

    visit "/directors/#{director.id}"

    expect(page).to have_text(director.name),
      "Expected page to have the name, '#{director.name}'"

    expect(page).to_not have_text(iris_roy.name),
      "Expected page to NOT have the name, '#{iris_roy.name}', but found it anyway."
  end
end

describe "/directors/[DIRECTOR ID]" do
  it "displays the dob of a specified Director record", points: 1 do
    director = Director.new
    director.name = "Travis McElroy"
    director.dob = 38.years.ago
    director.bio = "They really like films!"
    director.image = ""
    director.save

    visit "/directors/#{director.id}"

    expect(page).to have_text(director.dob),
      "Expected page to have the dob, '#{director.dob}'"
  end
end

describe "/directors/[DIRECTOR ID]" do
  it "displays the bio of a specified Director record", points: 1 do
    director = Director.new
    director.name = "Travis McElroy"
    director.dob = 38.years.ago
    director.bio = "They really like films!"
    director.image = ""
    director.save

    visit "/directors/#{director.id}"

    expect(page).to have_text(director.bio),
      "Expected page to have the bio, '#{director.bio}'"
  end
end

describe "/directors/[DIRECTOR ID]" do
  it "displays the names of the movies that were directed by the Director", points: 1 do
    director = Director.new
    director.name = "Travis McElroy"
    director.dob = 38.years.ago
    director.bio = "They really like films!"
    director.image = "https://robohash.org/Random%20Image?set=set4"
    director.save

    other_director = Director.new
    other_director.name = "Trina Kayetti"
    other_director.dob = 30.years.ago
    other_director.image = ""
    other_director.save

    the_turgle = Movie.new
    the_turgle.title = "The Turgle"
    the_turgle.description = "Matt Damon, being Matt Damon."
    the_turgle.year = 2008
    the_turgle.duration = 90
    the_turgle.director_id = director.id
    the_turgle.save

    hello_world = Movie.new
    hello_world.title = "Hello, World"
    hello_world.description = "Program's first world."
    hello_world.year = 2001
    hello_world.duration = 95
    hello_world.director_id = other_director.id
    hello_world.save

    deep_impact = Movie.new
    deep_impact.title = "Deep Impact"
    deep_impact.description = "It's like evangelion."
    deep_impact.year = 1999
    deep_impact.duration = 95
    deep_impact.director_id = director.id
    deep_impact.save

    visit "/directors/#{director.id}"

    expect(page).to have_text(the_turgle.title),
      "Expected page to have the title, '#{the_turgle.title}'"
    expect(page).to have_text(deep_impact.title),
      "Expected page to have the title, '#{deep_impact.title}'"
    expect(page).to_not have_text(hello_world.title),
      "Expected page to not have the title, '#{hello_world.title}'"
  end
end


describe "/directors/[DIRECTOR ID]" do
  it "has a 'Show details' link to the details page of each Movie in the Director's filmography", points: 1 do
    
    director = Director.new
    director.name = "Matthew Mercer"
    director.dob = 36.years.ago
    director.image = ""
    director.save

    other_director = Director.new
    other_director.name = "Trina Kayetti"
    other_director.dob = 30.years.ago
    other_director.image = ""
    other_director.save

    the_turgle = Movie.new
    the_turgle.title = "The Turgle"
    the_turgle.description = "Matt Damon, being Matt Damon."
    the_turgle.year = 2008
    the_turgle.duration = 90
    the_turgle.director_id = director.id
    the_turgle.save

    hello_world = Movie.new
    hello_world.title = "Hello, World"
    hello_world.description = "Program's first world."
    hello_world.year = 2001
    hello_world.duration = 95
    hello_world.director_id = other_director.id
    hello_world.save

    deep_impact = Movie.new
    deep_impact.title = "Deep Impact"
    deep_impact.description = "It's like evangelion."
    deep_impact.year = 1999
    deep_impact.duration = 95
    deep_impact.director_id = director.id
    deep_impact.save

    visit "/directors/#{director.id}"

    expect(page).to have_tag("a", :with => { :href => "/movies/#{the_turgle.id}" }, :text => /Show\s+details/i),
      "Expected page to have the a link with the text 'Show details' and an href of '/movies/#{the_turgle.id}'"

    expect(page).to have_tag("a", :with => { :href => "/movies/#{deep_impact.id}" }, :text => /Show\s+details/i),
      "Expected page to have the a link with the text 'Show details' and an href of '/movies/#{deep_impact.id}'"

    expect(page).to_not have_tag("a", :with => { :href => "/movies/#{hello_world.id}" }, :text => /Show\s+details/i),
      "Expected page to NOT have the a link with the text 'Show details' and an href of '/movies/#{hello_world.id}'"

  end
end
