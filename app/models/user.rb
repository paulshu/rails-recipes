class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :memberships
  has_many :groups, :through => :memberships
  has_many :registrations
  has_one :profile
    accepts_nested_attributes_for :profile
    #可以在更新 User 时，也顺便可以更新 Profile 资料
  def display_name
    self.email.split("@").first
  end

end
