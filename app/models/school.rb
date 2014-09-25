class School < ActiveRecord::Base
  belongs_to :division
  belongs_to :district
  belongs_to :thana
  belongs_to :union
  belongs_to :user, foreign_key: :created_by
  has_many :visits

  validates :year, :state, :division_id, :district_id, :thana_id, :union_id, :title, :headmaster_name, :phone, :boys, :girls, :presence => true

  accepts_nested_attributes_for :visits

  scope :pending, -> { where(status: 'pending') }
  scope :approved, -> { where(status: 'approved') }

  state_machine :status, :initial => :pending do
    event :approve do
      transition :pending => :approved
    end
  end


  def total_students
    [boys.to_i, girls.to_i].sum
  end
end
