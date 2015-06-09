class School < ActiveRecord::Base
  belongs_to :division
  belongs_to :district
  belongs_to :thana
  belongs_to :agency
  belongs_to :user, foreign_key: :created_by
  has_many :completion_certificates
  has_one :first_visit
  has_one :second_visit
  has_one :third_visit
  has_one :fourth_visit


  validates :year, :state, :division_id, :district_id, :thana_id, :union, :title, :headmaster_name, :boys, :girls,
            :agency_id, :quarter, :honorific, :mobile, :data_entry_operator, :presence => true

  validates :phone, :contact_number, numericality: true, allow_blank: true
  validates :boys, :girls, numericality: true
  validates :mobile, length: {minimum: 13, maximum: 14, message: 'Mobile Number should be 11 digits'}

  accepts_nested_attributes_for :first_visit
  accepts_nested_attributes_for :second_visit
  accepts_nested_attributes_for :third_visit
  accepts_nested_attributes_for :fourth_visit
  accepts_nested_attributes_for :completion_certificates, allow_destroy: true

  attr_accessor :remove_photo

  before_create :set_uniq_id

  scope :not_reviewed, -> { where(reviewed: false) }
  scope :not_draft, -> { where(draft: false) }
  scope :pending, -> { where(status: 'pending') }
  scope :admin_approved, -> { where(status: 'admin_approved') }
  scope :agency_approved, -> { where(status: 'agency_approved') }
  scope :approved, -> { where(status: ['agency_approved', 'admin_approved']) }
  scope :order_as_district, -> { order('district_id ASC') }
  scope :order_id_desc, -> { order('id DESC') }
  scope :by_agency, ->(agency_id) { where(agency_id: agency_id) }


  state_machine :status, :initial => :pending do
    event :agency_approve do
      transition :pending => :agency_approved
    end

    event :admin_approve do
      transition :agency_approved => :admin_approved
    end
  end

  def set_uniq_id
    number = loop do
      token = "UBL_#{self.agency.code}_#{self.thana.code}_#{rand(36**5).to_s(36)}"
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

  def headmaster
    [self.honorific, self.headmaster_name].join(" ")
  end

  def review!
    self.update_attributes(reviewed: true)
  end

  def agency_operator
    [self.data_entry_operator, self.agency.code].join("_")
  end

  def approved?
    self.status == "agency_approved" || self.status == "admin_approved"
  end

  def self.fetch_all(current_user, not_draft=false)

    if not_draft
      schools = School.not_draft
    else
      if current_user.admin?
        schools = School.agency_approved.not_reviewed
      elsif current_user.agency_admin?
        schools = School.by_agency(current_user.agency_id).not_draft
      elsif current_user.viewer?
        schools = School.admin_approved
      elsif current_user.operator?
        schools = School.by_agency(current_user.agency_id).load
      end
    end
    return {
        unique_id: schools.uniq_by(&:unique_id).count,
        division: schools.uniq_by(&:division).count,
        district: schools.uniq_by(&:district).count,
        thana: schools.uniq_by(&:thana).count,
        union: schools.uniq_by(&:union).count,
        title: schools.uniq_by(&:title).count,
        mobile: schools.uniq_by(&:mobile).count,
        boys: schools.sum(:boys),
        girls: schools.sum(:girls),
        total_student: schools.sum(:boys).to_i + schools.sum(:girls).to_i,
        back_checked: "Yes :: #{schools.where(back_checked: true).count} <br> No :: #{schools.where(back_checked: false).count}",
        spot_checked: "Yes :: #{schools.where(spot_checked: true).count} <br> No :: #{schools.where(spot_checked: false).count}"
    }
  end

end
