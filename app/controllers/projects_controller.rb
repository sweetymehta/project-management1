class ProjectsController < ApplicationController

  before_filter :fetch_workspace, only: [:index]

  # GET /projects
  # GET /projects.json
  def index
      
      @workspaces = current_user.workspaces
      # debugger
      @projects = Project.where(:workspace_id => @workspace)


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @workspaces = current_user.workspaces
    @project = Project.find(params[:id])
    @workspace = Workspace.find(params[:workspace_id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @workspaces = current_user.workspaces
    @project = Project.new
    @workspace = Workspace.find(params[:workspace_id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @workspaces = current_user.workspaces
    @project = Project.find(params[:id])
    @workspace = Workspace.find(params[:workspace_id])
  end

  # POST /projects
  # POST /projects.json
  def create
     @workspaces = current_user.workspaces
     @project = Project.new(params[:project])
     @project.user_id = current_user.id
     @workspace = Workspace.find(params[:workspace_id])
     @project.workspace = @workspace

    respond_to do |format|
      if @project.save
        format.html { redirect_to workspace_project_path(@workspace , @project), notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @workspaces = current_user.workspaces
    @project = Project.find(params[:id])
    @workspace = Workspace.find(params[:workspace_id])
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to workspace_project_tasks_path(@workspace , @project), notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])

    @workspace = Workspace.find(params[:workspace_id])
    @project.destroy

    respond_to do |format|
    format.html { redirect_to workspace_projects_path(@workspace)}
      format.json { head :no_content }
    end
  end


  # ======================
  # custom action for project dropdown values
  # ======================

  def project_dropdown
    @workspace =   params[:workspace_id]
    @projects = Project.where(:workspace_id => params[:workspace_id])

     respond_to do |format|
      format.js
    end

  end


  #  =====================
  #  = Protected methods =
  #  =====================
    def fetch_workspace
      # @workspace = current_path?(root_path) ? current_user.workspaces.first : Workspace.find(params[:workspace_id])
      @workspace = request.url == root_url ? current_user.workspaces.first : current_user.workspaces.find(params[:workspace_id])
    end
end
