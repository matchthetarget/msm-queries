require "rails_helper"

describe "/directors/youngest" do
  it "displays only the youngest directors name", :points => 1 do
    
    first_director = Director.new
    first_director.name = "John Smith"
    first_director.dob = 42.years.ago
    first_director.save
    
    second_director = Director.new
    second_director.name = "Conan O'Brien"
    second_director.dob = 101.years.ago
    second_director.save
    
    third_director = Director.new
    third_director.name = "Cathy Yan"
    third_director.dob = 36.years.ago
    third_director.save
    
    fourth_director = Director.new
    fourth_director.name = "Wes Anderson"
    fourth_director.dob = nil
    fourth_director.save

    visit "/directors/youngest"
    
    expect(page).to have_content(third_director.name),
      "Expected page to display #{third_director.name}, but didn't."
      
    expect(page).not_to have_content(first_director.name),
      "Expected page to NOT display #{first_director.name}, but did."
    expect(page).not_to have_content(second_director.name),
      "Expected page to NOT display #{second_director.name}, but did."
    expect(page).not_to have_content(fourth_director.name),
      "Expected page to NOT display #{fourth_director.name}, but did."
  end
end

describe "/directors/eldest" do
  it "displays only the eldest directors name", :points => 1 do
    
    first_director = Director.new
    first_director.name = "John Smith"
    first_director.dob = 42.years.ago
    first_director.save
    
    second_director = Director.new
    second_director.name = "Conan O'Brien"
    second_director.dob = 101.years.ago
    second_director.save
    
    third_director = Director.new
    third_director.name = "Cathy Yan"
    third_director.dob = 36.years.ago
    third_director.save
    
    fourth_director = Director.new
    fourth_director.name = "Wes Anderson"
    fourth_director.dob = nil
    fourth_director.save

    visit "/directors/eldest"
    
    expect(page).to have_content(second_director.name),
      "Expected page to display #{second_director.name}, but didn't."
      
    expect(page).not_to have_content(first_director.name),
      "Expected page to NOT display #{first_director.name}, but did."
    expect(page).not_to have_content(third_director.name),
      "Expected page to NOT display #{third_director.name}, but did."
    expect(page).not_to have_content(fourth_director.name),
      "Expected page to NOT display #{fourth_director.name}, but did."
  end
end
