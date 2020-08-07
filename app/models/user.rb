class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :posts, dependent: :destroy
         has_many :post_comments, dependent: :destroy
         has_many :favorites, dependent: :destroy

         attachment :profile_image

         #following association
         has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy #フォローしている人を限定していない
         has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy #foreign_keyで検索できるようにしている
         has_many :following_user, through: :follower, source: :followed #名前が違うrelationshipを参照している
         has_many :follower_user, through: :followed, source: :follower #テーブル作成する際にforeign_key使用

         def follow(user_id)
          follower.create(followed_id: user_id)
         end

         def unfollow(user_id)
          follower.find_by(followed_id: user_id).destroy
         end

         def following?(user)
          following_user.include?(user)
         end

         scope  :for_date_range, -> (start_date, end_date) do
          where(created_at: start_date.beginning_of_day..end_date.end_of_day)
         end

         scope :count_by_date, -> () do
          group('date(created_at)').count
         end
end
