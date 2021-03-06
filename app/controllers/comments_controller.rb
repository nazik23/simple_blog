class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: :index

  # GET /comments
  # GET /comments.json
  def index
		@comments = Post.find_by(id: params[:post_id]).comments.all
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
		@comment = current_user.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to posts_url, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
				format.js

				@owner = {first_name: current_user.first_name,\
 				 	last_name: current_user.last_name}
				@action = "new Comment"
				@post_owner = User.find(Post.find(comment_params[:post_id]).user_id)
				ActionCable.server.broadcast 'comments',
				html: render_to_string('/alert', layout: false)
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to posts_url, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
				format.js
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body, :post_id)
    end
end
