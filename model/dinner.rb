require 'mongo_mapper'

class Dinner
  include MongoMapper::Document

  #Attributes
  key :title, String, :required => true
  key :event_date, Date
  key :description, String, :required => true
  key :hosted_by, String, :required => true
  key :contact_phone, String, :required => true
  key :address, String, :required => true
  key :country, String, :required => true
  key :latitude, Float
  key :longitude, Float
  timestamps!

  #Associations
  #many :rsvps
end
