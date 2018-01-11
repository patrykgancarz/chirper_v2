class GroupsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_group, only: [:show, :edit, :update, :destroy, :follow, :unfollow]
  before_action :require_token, only: [:follow, :unfollow]
  swagger_controller :groups, 'Groups'

 swagger_api :follow do
   summary 'Follows a group'
   notes 'Notes...'
   param	:header,	"Authorization",	:string,	:required,	"Authentication	token"
   param :path, :id, :integer, :required, "Group id"
 end
 def follow
   unless current_user.follows?(@group)
     current_user.groups.append(@group)
   end
   redirect_to @group
 end

 swagger_api	:unfollow	do
   summary	'Unfollows	a	group'
   notes	'Notes...'
   param	:header,	"Authorization",	:string,	:required,	"Authentication	token"
   param	:path,	:id,	:integer,	:required,	"Group	id"
 end
 def unfollow
   if current_user.follows?(@group)
     @group.users.delete(current_user)
   end
   redirect_to @group
 end


  # GET /groups
  # GET /groups.json
  swagger_api	:index	do
    summary	'Returns	all	groups'
    notes	'Notes...'
  end
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  swagger_api	:show	do
    summary	'Returns	one	group'
    param	:path,	:id,	:integer,	:required,	"Group	id"
    notes	'Notes...'
  end
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end


  # POST /groups
  # POST /groups.json
  swagger_api	:create	do
    summary	"Create	a	group"
    param	:form,	"group[name]",	:string,	:required,	"Group	name"
    param	:form,	"group[description]",	:string,	:required,	"Group	description"
  end
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  swagger_api	:update	do
    summary	"Update	a	group"
    param	:path,	:id,	:integer,	:required,	"Course	id"
    param	:form,	"group[name]",	:string,	:required,	"Group	name"
    param	:form,	"group[description]",	:string,	:required,	"Group	description"
  end
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  swagger_api	:destroy	do
    summary	'Destroys	a	group'
    param	:path,	:id,	:integer,	:required,	"Group	id"
    notes	'Notes...'
  end
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :description)
    end
end
