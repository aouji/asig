class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :votes, dependent: :destroy
  has_many :voted_projects, through: :votes, source: :project

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
