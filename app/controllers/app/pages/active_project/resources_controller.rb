class App::Pages::ActiveProject::ResourcesController < App::Pages::ActiveProjectController
  skip_before_action :verify_authenticity_token, :only => [:associate]

  layout 'app'

  def add
    project_resource_ids = @project.resources.ids
    @available_resources = Resource.where.not(id: project_resource_ids).pluck(:name, :id)
    
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def index
    @resources = @project.resources.order(:name)
  end

  def remove
    resource = Resource.find(params[:resource_id])
    
    if @project.resources.delete(resource)
      flash[:notice] = t('shared.success')
    else
      flash[:alert] = t('shared.error')
    end

    redirect_to request.referer
  rescue
    flash[:alert] = t('shared.error')
    redirect_to request.referer
  end

  def associate
    resource = Resource.find(params[:resource_id])

    if @project.resources << resource
      flash[:notice] = t('shared.success')
    else
      flash[:alert] = t('shared.error')
    end

    redirect_to request.referer
  rescue
    flash[:alert] = t('shared.error')
    redirect_to request.referer
  end
end
