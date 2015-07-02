class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :firstname, :lastname, :role_ids, :username, :email, :password, :password_confirmation, :remember_me

  validates_presence_of :username #Other validates are brought in by validatable module above
  # attr_accessible :title, :body

  def role?(role)
    self.roles.include? role.to_s
  end
end

