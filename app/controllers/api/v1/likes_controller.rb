class Api::V1::LikesController < ApplicationController
    def create
        # uidが一致する場合のみ処理を実行
        # return if User.find(like_post_params[:user_id]).uid != like_post_params[:uid]
    
        like = Like.new(like_post_params.except(:uid))
        if like.save
          render status: :created, json: true
        end
      end
    
      def destroy
        like = Like.find_by(user_id: params[:user_id], post_id: params[:post_id])
    
        # uidが一致する場合のみ処理を実行
        # return if like.user.uid != params[:uid]
    
        like.destroy
        render status: 200, json: false
      end

      private
      def like_post_params
        params.require(:like).permit(:user_id, :post_id, :uid)
      end
    
end
