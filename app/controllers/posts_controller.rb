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
            flash[:danger] = "投稿できません"
            render 'new'
        end
    end

    def index
        @posts = Post.page(params[:page]).per(10).order(created_at: :desc)
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
