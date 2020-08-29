class Post < ApplicationRecord
    belongs_to :user

    has_many :post_comment, dependent: :destroy
    has_many :favorites, dependent: :destroy
    
    attachment :image

    paginates_per 9

    # default_scope -> { order(created_at: :desc) }
    
    def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end

<<<<<<< HEAD
=======
    # scope :data_format, -> {select("DATE_FORMAT('created_at', '%Y年%m月%d日') as data, fee")}

>>>>>>> e4d632cc86b024caf76559184b816de75c29af08
    scope  :for_date_range, -> (start_date, end_date) do
        where(created_at: start_date.beginning_of_day..end_date.end_of_day)
    end

    scope :count_sum, -> () do
        group('date(created_at)').sum(:fee)
    end
end
