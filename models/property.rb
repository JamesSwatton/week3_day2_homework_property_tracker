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

  def delete
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "DELETE FROM property_tracker WHERE id = $1;"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

  def update
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "UPDATE property_tracker SET (value, number_bedrooms, year_built, buy_let_status) = ($1, $2, $3, $4) WHERE id = $5;"
    values = [@value, @number_bedrooms, @year_built, @buy_let_status, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def find(id)
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "SELECT * FROM property_tracker WHERE id = $1;"
    values = [id]
    db.prepare("find", sql)
    property_hash = db.exec_prepared("find", values)
    found_property = Property.new(property_hash[0])
    db.close()
    return found_property
  end

end
