class Api::V1::RelationshipsController < ApplicationController
    before_action :set_user
        def create
            return if @current_user.uid != params[:uid]

            @current_user.follow(@other_user)
            render json: @other_user
        end
    
        def destroy
            # uidが一致する場合のみ処理を実行
            return if @current_user.uid != params[:uid]
        
            @current_user.unfollow(@other_user)
            render json: @other_user
        end
        

        def followings
            user = User.find(params[:user_id])
            @users = user.followings
        end
        
        def followers
            user = User.find(params[:user_id])
            @users = user.followers
        end

    private
        def set_user
        @current_user = User.find(params[:user_id])
        @other_user = User.find(params[:follow_id])
        end
end
