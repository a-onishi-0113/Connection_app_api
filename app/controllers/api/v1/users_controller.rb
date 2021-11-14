class Api::V1::UsersController < ApplicationController
    before_action :set_user, only: [:update, :destroy]
  
    # GET /api/v1/users
    def index
      if params[:uid] 
        current_user = User.with_attached_avatar.find_by(uid: params[:uid])
        render json: current_user.as_json(methods: :avatar_url)
      #=============================================================================================
      # ユーザー全件を返す
      #=============================================================================================
      else
        @users = User.all
        render json: @users
      end
    end
  
    # GET /api/v1/users/1
    def show
      @user = User.find(params[:id])
      render json: @user.as_json(include: [{following: {except: [:uid, :email]}},{followers: {except: [:uid, :email]}}],methods: :avatar_url)
    end
  
    # POST /api/v1/users
    def create
      @user = User.new(user_params)
      if @user.save
        render json: '作成に成功しました', status: 200
      else
        render json: '作成に失敗しました', status: 500
      end
    end
  
    # PATCH/PUT /api/v1/users/1
    def update
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def search
      
        # users = User.find_by(name: params[:name])
        users = User.search(params[:name])
        render json: users.as_json(include: [{following: {except: [:uid, :email]}},{followers: {except: [:uid, :email]}}],methods: :avatar_url)
        
      
    end
  
    # DELETE /api/v1/users/1
    def destroy
      # logger.debug(@user)
      return if @user.uid != params[:uid]
      @user.destroy
    end

    def update_avatar
      # uidが一致する場合のみ処理を実行
      # return if @user.uid != params[:uid]
      @user = User.find_by!(uid: params[:uid])
      @user.avatar.attach(params[:avatar])
    render json: @user, methods: [:avatar_url]
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def user_params
        params.require(:user).permit(:name, :email, :uid, :profile)
      end
    
end
