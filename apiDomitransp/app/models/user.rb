class User < ApplicationRecord
  has_one :code
  belongs_to :company, counter_cache: true
  has_one :code
  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # mount_uploader :avatar, AvatarUploader

end
