class Post < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_many_attached :images
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  belongs_to :user


  validates :content, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :formatted_address, presence:true

  def self.search(formatted_address)
    Post.where(['formatted_address LIKE ?', "%#{formatted_address}%"])
  end

  def images_url
    if images.attached?
      i = 0
      count = images.length
      imageList = []
      while i < count
        imageList.push(url_for(images[i]))
        i += 1
      end
      return imageList
    else
      return nil
    end
  end

end
