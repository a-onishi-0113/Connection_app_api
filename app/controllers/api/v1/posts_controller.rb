class Api::V1::PostsController < ApplicationController
    def index
        # フォロワーの投稿取得　@posts = Post.where(user_id: [User.find(1).follower_ids])
        if params[:user_id].present?
            logger.debug(":user_id文の中に入りました")
            user = User.find_by(id: params[:user_id])
            following = user.following
            posts = []
            user.posts.each do |p|
                posts.push(p)
            end
            following.each do |f|
                f.post.each do |p|
                    posts.push(p)
                end
            end
            posts.uniq!
            posts.sort! do |a, b|
                b[:created_at] <=> a[:created_at]
            end
            render json: posts.as_json(include: [{user: {methods: :avatar_url, except: [:uid, :email]}},{liked_users: {except: [:uid, :email]}},{post_comments: {include: {user: {methods: :avatar_url,except: [:uid, :email]}},methods: :images_url}}],methods: :images_url)
        elsif params[:otherUser_id].present?
            logger.debug(":otherUser_id文の中に入りました")
            user = User.find_by(id: params[:otherUser_id])
            posts = user.posts
            render json: posts.as_json(include: [{user: {methods: :avatar_url, except: [:uid, :email]}},{liked_users: {except: [:uid, :email]}},{post_comments: {include: {user: {methods: :avatar_url,except: [:uid, :email]}},methods: :images_url}}],methods: :images_url)
        else
            logger.debug("else文の中に入りました")
        end
    end

    def create
        if User.find(post_content_params[:user_id]).uid = post_content_params[:uid]
            post = Post.new(post_content_params.except(:uid))
            images = params[:images]
            images.each do |i|
                post.images.attach(i)
            end
            if post.save
            render json: post, methods: [:images_url]
            else
            render json: '作成に失敗しました', status: 500
            end

        else
            render json: 'ユーザーが違います。', status: 200
        end
    end

    def show
        posts = Post.find_by(id: params[:id])
        logger.debug(posts)
        render json: posts.as_json(include: [{user: {methods: :avatar_url, except: [:uid, :email]}},{liked_users: {except: [:uid, :email]}},{post_comments: {include: {user: {methods: :avatar_url,except: [:uid, :email]}},methods: :images_url}}],methods: :images_url)
    end

    def destroy
        
        if Post.find(params[:id]).destroy
            render json: '削除に成功しました', status: 200
        else
            render json: '削除に失敗しました', status: 500
        end
    end

    def search
        logger.debug("住所検索に入りました")
        posts = []
        users = User.all
        users.each do |u|
            logger.debug(u.post)
            result = u.post.search(params[:formatted_address])
                result.each do |r|
                posts.push(r) 
            end
        end 
        render json: posts  
      
    end

    private

        def set_params
            params.require(:post).permit(:content)
        end

        def post_content_params
            params.require(:post).permit(:title, :content, :user_id, :uid, :latitude, :longitude, :formatted_address)
        end

        
    end

