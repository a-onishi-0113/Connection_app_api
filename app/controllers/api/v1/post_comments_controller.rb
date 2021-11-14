class Api::V1::PostCommentsController < ApplicationController
    def create
        # uidが一致する場合のみ処理を実行
        # return if User.find(comment_params[:user_id]).uid != comment_params[:uid]
        @comment = PostComment.new(comment_params.except(:uid))
        @comment = PostComment.new(comment_params.except(:uid))
        # images = params[:images]
        #     images.each do |i|
        #         @comment.images.attach(i)
        #     end
        if @comment.save
          render json: @comment.as_json(include: {user: {methods: :avatar_url,except: [:uid, :email]}})
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @comment = PostComment.find_by(id: params[:comment_id])
    
        # # uidが一致する場合のみ処理を実行
        # return if @comment.user.uid != params[:uid]
    
        @comment.destroy
        render json: '削除に成功しました', status: 200
    end
    private

        def comment_params
        comment_params = params.require(:post_comment).permit(:comment, :post_id, :user_id, :uid, images: [])
        end
end
