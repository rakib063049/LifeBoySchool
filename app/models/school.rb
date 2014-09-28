class School < ActiveRecord::Base
  belongs_to :division
  belongs_to :district
  belongs_to :thana
  belongs_to :agency
  belongs_to :user, foreign_key: :created_by
  has_many :visits

  validates :year, :state, :division_id, :district_id, :thana_id, :union, :title, :headmaster_name, :boys, :girls, :presence => true

  accepts_nested_attributes_for :visits

  before_create :set_uniq_id

  scope :pending, -> { where(status: 'pending') }
  scope :approved, -> { where(status: 'approved') }
  scope :order_as_district, -> { order('district_id ASC') }

  state_machine :status, :initial => :pending do
    event :approve do
      transition :pending => :approved
    end
  end

  def set_uniq_id
    number = loop do
      token = "#{self.agency.name}_#{self.thana.code}_#{rand(36**5).to_s(36)}"
      break token.upcase! unless School.exists?(unique_id: token)
    end
    self.unique_id = number
  end

  def total_students
    [boys.to_i, girls.to_i].sum
  end

  def created_by
    self.user.try(:name)
  end
end
