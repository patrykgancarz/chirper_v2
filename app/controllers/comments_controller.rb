class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :require_token, only: [:create]
  swagger_controller	:posts,	'Posts'

  # GET /comments/1
  # GET /comments/1.json
  swagger_api	:show	do
    summary	'Returns	one	comment'
    param	:path,	:group_id,	:integer,	:required,	"Group	id"
    param	:path,	:post_id,	:integer,	:required,	"Post	id"
    param	:path,	:id,	:integer,	:required,	"Comment	id"
    notes	'Notes...'
  end
  def show
  end

  # GET /comments/new
  def new
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  swagger_api	:create	do
    summary	"Create	new	comment"
    param	:header,	"Authorization",	:string,	:required,	"Authentication	token"
    param	:path,	:group_id,	:integer,	:required,	"Group	id"
    param	:path,	:post_id,	:integer,	:required,	"Post	id"
    param	:form,	"comment[body]",	:string,	:required,	"Body	of	a	comment"
  end
  def create
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to [@group, @post], notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  swagger_api	:update	do
    summary	"Update	a	comment"
    param	:path,	:id,	:integer,	:required,	"Comment	id"
    param	:path,	:post_id,	:integer,	:required,	"Post	id"
    param	:path,	:group_id,	:integer,	:required,	"Group	id"
    param	:form,	"comment[body]",	:string,	:required,	"Body	of	a	comment"
  end
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to [@group, @post], notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  swagger_api	:destroy	do	|post|
    summary	'Destroys	a	comment'
    param	:path,	:id,	:integer,	:required,	"Comment	id"
    param	:path,	:post_id,	:integer,	:required,	"Post	id"
    param	:path,	:group_id,	:integer,	:required,	"Group	id"
    notes	'Notes...'
  end
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @group = Group.find(params[:group_id])
      @post = Post.find(params[:post_id])
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body, :user_id, :post_id)
    end
end
