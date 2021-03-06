class PostCommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        comment = current_user.post_comments.new(post_comment_params)
        comment.post_id = @post.id
        if comment.save
        else
            flash[:danger] = "短すぎます"
            redirect_back(fallback_location: root_path)
        end
    end

    def destroy
        @post_comment = PostComment.find_by(id: params[:id], post_id: params[:post_id])
        @post_comment.destroy
    end

    private
    def post_comment_params
        params.require(:post_comment).permit(:comment)
    end
end
