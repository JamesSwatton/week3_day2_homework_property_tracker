require('pg')

class Property

  attr_accessor :value, :number_bedrooms, :year_built, :buy_let_status
  attr_reader :id

  def initialize(options)
    @id  = options['id'].to_i if options['id']
    @value = options['value'].to_i
    @number_bedrooms = options['number_bedrooms'].to_i
    @year_built  = options['year_built'].to_i
    @buy_let_status  = options['buy_let_status']
  end


  def save
  db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
  sql = "INSERT INTO property_tracker (value, number_bedrooms, year_built, buy_let_status) VALUES ($1,$2,$3,$4) RETURNING id;"
  values = [@value, @number_bedrooms, @year_built, @buy_let_status]
  db.prepare("save", sql)
  property_hashes = db.exec_prepared("save", values)
  @id = property_hashes[0]['id']
  db.close()
  end








end
