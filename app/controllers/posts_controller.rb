class PostsController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index]

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id
        if @post.save
            flash[:success] = "投稿完了"
            redirect_to @post
        else
            render 'new'
        end
    end

    def index
        if params[:posts] == "following_posts"
            @follow_users = current_user.following_user
            @posts = Post.where(user_id: @follow_users).or(Post.where(user_id: current_user)).page(params[:page]).order(created_at: :desc)
        elsif params[:posts] == "recommend"
            @posts = Post.where.not(user_id: current_user.id).page(params[:page]).order(created_at: :desc)
            render :recommend
        else
            @posts = Post.page(params[:page]).order(created_at: :desc)
        end        
    end

    def show
        @post = Post.find(params[:id])
        @post_comment = PostComment.new
        
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        @post.user_id = current_user.id
        if @post.save
            flash[:success] = "更新完了"
            redirect_to post_path(@post)
        else
            flash[:danger] = "更新できませんでした"
            render 'edit'
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to posts_path
    end

    private
    def post_params
        params.require(:post).permit(:caption, :fee, :image)
    end

end
