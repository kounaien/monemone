class Post < ApplicationRecord
    belongs_to :user

    has_many :post_comment, dependent: :destroy
    has_many :favorites, dependent: :destroy
    
    attachment :image

    def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end
end
