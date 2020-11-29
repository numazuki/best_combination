class Post < ApplicationRecord
  belongs_to :user
  belongs_to :tag 
  mount_uploader :img, ImgUploader
  
  has_many :favorites
  has_many :favorite_users,through: :favorites,source: :users
  
  validates :content, presence: true, length: { maximum: 400 }
  validates :sake_name, presence: true, length: { maximum: 50 }
  validates :meshi_name, presence: true, length: { maximum: 50}

  def self.search(search)
    if search
      Post.where(['content LIKE ? OR sake_name LIKE ? OR meshi_name LIKE ?', "%#{search}%","%#{search}%","%#{search}%"])
    else
      Post.all
    end
  end
end
