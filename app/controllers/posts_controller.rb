class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: :index  
	before_action :check_post_owner, except: [:new, :index, :create]

  # GET /posts
  # GET /posts.json
  def index
		lam = -> (*arg){ Post.includes(:tags, :taggings).send(*arg) }
    if params[:tag]
#@posts = Post.tagged_with(params[:tag])
			@posts = lam[:tagged_with, params[:tag]]
		elsif params[:all]
#	@posts = Post.includes(:tags).all
			@posts = lam[:all]
		else
	    @posts = user_signed_in? ? current_user.posts : lam[:all]
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
	  @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_url, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }

				@owner = {first_name: current_user.first_name, last_name: current_user.last_name}
				@action = "new Post"
				ActionCable.server.broadcast 'posts',
				html: render_to_string('/alert', layout: false) 
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to posts_url, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :tag_list, :picture)
    end

    def check_post_owner
	    redirect_to posts_url, notice: 'Access denied!' unless @post.user_id == current_user.id
    end
end
