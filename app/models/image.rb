class Image < ActiveRecord::Base
  belongs_to :visit

  has_attached_file :photo,
                    :styles => {thumb: '100x100>', original: '634x471>'},
                    :convert_options => { :original => '-quality 40' }


  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
end
