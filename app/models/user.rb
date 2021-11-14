class User < ApplicationRecord
    include Rails.application.routes.url_helpers
    
      has_one_attached :avatar, dependent: :destroy
      has_many :posts, dependent: :destroy
      has_many :likes, dependent: :destroy
      has_many :liked_posts, through: :likes, source: :post
      has_many :post_comments, dependent: :destroy
      has_many :active_relationships, class_name:  "Relationship",
                                      foreign_key: "follower_id",
                                      dependent:   :destroy
      has_many :passive_relationships, class_name:  "Relationship",
                                      foreign_key: "followed_id",
                                      dependent:   :destroy
      has_many :following, through: :active_relationships, source: :followed, dependent: :destroy
      has_many :followers, through: :passive_relationships, source: :follower, dependent: :destroy
  
      validates :name, presence: true,length: { maximum: 20 }
      validates :uid, presence: true
      validates :email, presence: true, uniqueness: true
      validates :profile, length: { maximum: 255 }
      
      # ユーザーをフォローする
    def follow(other_user)
      following << other_user
    end
  
    # ユーザーをフォロー解除する
    def unfollow(other_user)
      active_relationships.find_by(followed_id: other_user.id).destroy
    end
  
    # 現在のユーザーがフォローしてたらtrueを返す
    def following?(other_user)
      following.include?(other_user)
    end
  
    def self.search(user_name)
      User.where(['name LIKE ?', "%#{user_name}%"])
    end
  
    def image_url
      # 紐づいている画像のURLを取得する
      image.attached? ? url_for(image) : nil
    end
  
    def avatar_url
      # 紐づいている画像のURLを取得する
      avatar.attached? ? url_for(avatar) : nil
    end
    
  end
  