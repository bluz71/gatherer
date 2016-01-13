class User < ActiveRecord::Base
  has_many :roles
  has_many :projects, through: :roles

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def can_view?(project)
    return true if admin? || project.public?
    projects.include?(project)
  end
end
