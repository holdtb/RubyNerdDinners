require 'mongo_mapper'

class Dinner
  include MongoMapper::Document
  #Attributes
  key :_id, ObjectId
  key :title, String, :required => true
  key :event_date, Date
  key :description, String, :required => true
  key :hosted_by, String, :required => true
  key :contact_phone, String
  key :address, String, :required => true
  key :country, String, :required => true
  key :latitude, Double, :required => true
  key :longitude, Double, :required => true
  timestamps!

  #Validations
  RegPhoneNum = "^[2-9]\\d{2}-\\d{3}-\\d{4}$"
  validates_format_of :contact_phone, with => RegPhoneNum, :allow_blank => false

  #Associations
  many :rsvps
end
