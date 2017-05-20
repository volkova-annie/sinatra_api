class Apply < Sequel::Model

  # field :job_id, type: Object
  # field :geek_id, type: Object
  # field :read, type: Boolean, default: false
  # field :invited, type: Boolean, default: false

  # validates :name, presence: true
  # validates :location, presence: true

  # validates :resume, presence: true

  # index({ job_id: 1 })

  # scope :job_id, -> (job_id) { where(job_id: "#{job_id}") }
  # scope :geek_id, -> (geek_id) { where(geek_id: geek_id) }
  # scope :apply_geek, -> (geek_id) { where(geek_id: geek_id) }
  # scope :read, -> { where(read: true) }
  # scope :unread, -> { where(read: false) }
  # scope :invited, -> { where(invited: true) }
  # scope :denied, -> { where(invited: false) }

  def to_api # Not for array!!
    {
        id: id,
        read: read,
        invited: invited,
        job_id: job_id,
        geek_id: geek_id,
    }
  end

  def self.read
    where(read: true)
  end

  def self.unread
    where(read: false)
  end

end