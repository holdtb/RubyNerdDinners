require 'mongo_mapper'

class RSVP
  include MongoMapper::Document

  key :_id  #This is a unique/autoincrementing BSON ObjectId, NOT an int
  key :dinner_id, ObjectId
  key :attendee_name, String

  belongs_to :dinner
end
