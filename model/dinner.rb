require 'mongo_mapper'

class Dinner
  include MongoMapper::Document

  key :_id  #This is a unique/autoincrementing BSON ObjectId, NOT an int
  key :title, String
  key :event_date, Date
  key :description, String
  key :hosted_by, String
  key :contact_phone, String
  key :address, String
  key :country, String
  key :latitude, Double
  key :longitude, Double


  many :rsvps
end
