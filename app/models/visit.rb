class Visit < ActiveRecord::Base
  belongs_to :school
  belongs_to :agency
  belongs_to :user, foreign_key: :created_by
  has_many :images
  validates :quarter, :visited_at, :agency_id, :presence => true

  QUARTER = ['Q1 (JAN-MAR)', 'Q2 (APR-JUN)', 'Q3 (JULY-SEP)', 'Q4 (OCT-DEC)']

  scope :approved, -> { where(approve: true) }

  accepts_nested_attributes_for :images


end
