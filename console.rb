require('pry-byebug')
require_relative('models/property')

property = Property.new({'value' => '131000', 'number_bedrooms' => '3', 'year_built' => '2000', 'buy_let_status' => 'buy'})

property.save()
