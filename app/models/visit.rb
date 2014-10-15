class Visit < ActiveRecord::Base
  belongs_to :school
  belongs_to :user, foreign_key: :created_by
  has_many :images
  has_many :students_images
  has_many :acknowledgement_certificates
  validates :visited_at, :presence => true

  QUARTER = ['Q1 (JAN-MAR)', 'Q2 (APR-JUN)', 'Q3 (JULY-SEP)', 'Q4 (OCT-DEC)']

  scope :approved, -> { where(approve: true) }

  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :students_images, allow_destroy: true
  accepts_nested_attributes_for :acknowledgement_certificates, allow_destroy: true


end
