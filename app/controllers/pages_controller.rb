class PagesController < ApplicationController
  def contact; end
  
  def index; end

  def team
    @team = Profile.actives.by_roles
  end
end
