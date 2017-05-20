class Company < Sequel::Model
  one_to_many :jobs

  plugin :validation_helpers

  def validate
    super
    errors.add(:name, "can't be empty") if name.empty?
    validates_presence [:name, :location]
    validates_unique [:name]
  end

  def company_to_api # Not for array!!
    {
        id: id.to_s,
        name: name,
        location: location,
    }
  end

  # dataset_module do # Model scope's OR self.
  def self.by_name(name)
    res = []
    res = where(name: /#{name}/i) if name
    puts "In by_name dataset mod: res = #{res.inspect}"
    # res.empty? ? [].to_json : collection_to_api(res)
    res.empty? ? [] : res
  end
  # end

  dataset_module do # Model scope's OR self.
    def by_location(location)
      puts 'In by_location dataset mod'
      where(location: /#{location}/i) if location
    end
  end

  def self.company_jobs(name)
    company = Company.by_name(name)#[:id]
    puts "company = #{company.inspect}" if company
    # puts "company = #{company.columns.inspect}" unless company.to_a == []
    # company = [:id, :name, :location, :created_at, :upated_at]
    # puts "company = #{company.map(:id).inspect}"
    # company# = [2]
    puts "company.count = #{company.count}" unless company.nil?

    company_id = company.map(:id)[0] unless company == [] || company == nil

    puts "company_id = #{company_id.inspect}"
    # company_id
    # company_id_select_map = company.select_map(:id) unless company.to_a == []
    # puts "company_id_select_map = #{company_id_select_map.inspect}"
    # company_id = company.select(:id).naked.all.inspect
    # "[{:id=>2}]"
    # company_id.nil? ? [].to_json : company_id.to_json
    # puts "company_id = #{company_id.to_json}"
    company_jobs = Job.company_jobs(company_id) unless company_id.nil?
    puts "company_jobs = #{company_jobs.count}"  unless company_jobs.nil?
    puts "company_jobs = #{company_jobs.inspect}"
    company_jobs.nil? ? [].to_json : collection_to_api(company_jobs)
  end


  def call_one_method(model_name, method, params)
    if params
      model_name.send(method, params)
    else
      puts "Enter Name!"
      [].to_json
    end
  end

end