class Visit < ActiveRecord::Base
  belongs_to :school
  belongs_to :agency
  belongs_to :user, foreign_key: :created_by
  validates :quarter, :visited_at, :school_id, :agency_id, :presence => true

  QUARTER = ['Q1 (JAN-MAR)', 'Q2 (APR-JUN)', 'Q3 (JULY-SEP)', 'Q4 (OCT-DEC)']

  scope :approved, -> { where(approve: true) }

end
