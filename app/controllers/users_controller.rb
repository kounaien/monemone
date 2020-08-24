class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update]
    before_action :correct_user, only: [:edit]

    def show
        @post = Post.find(params[:id])
        @post_comment = PostComment.new
        @posts = @user.posts.all
        if @posts.any?
            @count_sum = @user.posts.for_date_range(@user.posts.first.created_at, @user.posts.last.created_at).count_sum
            total = 0
            @count_sum.each do |key, value|
                total += value
            end
            @count_sum["#{Date.today}までの"] = total
        end
    end

    def edit
    end

    def update
        if @user.update(user_params)
            flash[:success] = "更新完了"
            redirect_to user_path(@user)
        else
            flash[:danger] = "更新できませんでした"
            render 'edit'
        end
    end

    def search
        @users = User.where('name LIKE(?)', "%#{params[:keyword]}%")
        render json: @users
    end

    private
    def set_user
        @user = User.find(params[:id])
    end

    def correct_user
        @user = User.find(params[:id])
        unless @user.id == current_user.id
            redirect_to root_path
        end
    end

    def user_params
        params.require(:user).permit(:profile_image, :name, :self_introduction, :last_name, :first_name)
    end
end
