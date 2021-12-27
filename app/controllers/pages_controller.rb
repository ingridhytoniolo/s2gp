class PagesController < ApplicationController
  def contact; end
  
  def index; end

  def team
    @team = Profile.by_roles
  end
end
