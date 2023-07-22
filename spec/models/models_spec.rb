require "rails_helper"

describe "Movie" do
  it "has a class defined in app/models/", points: 1 do
    expect{ Movie }.to_not raise_error(NameError),
      "Expected a Movie class to be defined in the app/models/ folder, but didn't find one."
  end
end

describe "Director" do
  it "has a class defined in app/models/", points: 1 do
    expect{ Director }.to_not raise_error(NameError),
      "Expected a Director class to be defined in the app/models/ folder, but didn't find one."
  end
end

describe "Actor" do
  it "has a class defined in app/models/", points: 1 do
    expect{ Actor }.to_not raise_error(NameError),
      "Expected a Actor class to be defined in the app/models/ folder, but didn't find one."
  end
end

describe "Character" do
  it "has a class defined in app/models/", points: 1 do
    expect{ Character }.to_not raise_error(NameError),
      "Expected a Character class to be defined in the app/models/ folder, but didn't find one."
  end
end
