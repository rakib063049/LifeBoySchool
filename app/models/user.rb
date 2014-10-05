class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  belongs_to :agency
  validates :first_name, :last_name, :title, :roles, :agency_id, :presence => true

  scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }

  ROLES = %w[admin agency_admin operator viewer ]

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end

  def admin?
    role?(:admin)
  end

  def agency_admin?
    role?(:agency_admin)
  end

  def operator?
    role?(:operator)
  end

  def viewer?
    role?(:viewer)
  end

  def name
    [self.first_name, self.last_name].join(" ")
  end

end
