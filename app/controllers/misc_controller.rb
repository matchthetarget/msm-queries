class MiscController < ApplicationController
  def homepage
    render({ :template => "misc_templates/home"})
  end
end
