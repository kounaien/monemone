class Post < ApplicationRecord
    belongs_to :user

    has_many :post_comment, dependent: :destroy
    has_many :favorites, dependent: :destroy
    
    attachment :image

    def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end

    scope  :for_date_range, -> (start_date, end_date) do
        where(created_at: start_date.beginning_of_day..end_date.end_of_day)
    end

    scope :count_sum, -> () do
        group('date(created_at)').sum(:fee)
    end
end
