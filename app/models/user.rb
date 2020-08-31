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

         validates :self_introduction, length: { minimum: 5, maximum: 150 }
         validates :name, presence: true, length: { maximum: 30 }
         validates :first_name, length: { maximum: 30 }
         validates :last_name, length: { maximum: 30 }
         VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
         validates :email, presence: true, uniqueness: true, length: { maximum: 40 }, format: { with: VALID_EMAIL_REGEX }

         def follow(user_id)
          follower.create(followed_id: user_id)
         end

         def unfollow(user_id)
          follower.find_by(followed_id: user_id).destroy
         end

         def following?(user)
          following_user.include?(user)
         end
end
