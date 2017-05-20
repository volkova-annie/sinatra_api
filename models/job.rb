class Job < Sequel::Model
  many_to_one :company

  # validates :place, presence: true
  # validates :company_id, presence: true
  # validates :name, presence: true

  # scope :place, -> (place) { where(place: /^#{place}/i) }
  # scope :name, -> (name) { where(name: /^#{name}/i) }
  # scope :company_id, -> (company_id) { where(company_id: company_id) }

  def to_api
    {
        id: id,
        name: name,
        company_id: company_id,
        place: place,
        # description: description,
    }
  end

  def self.company_jobs(company_id)
    where(company_id: company_id)
  end


end