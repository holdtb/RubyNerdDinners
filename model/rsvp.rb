require 'mongo_mapper'

class RSVP
  include MongoMapper::Document

  key :_id
  key :attendee_name, String

  belongs_to :dinner
end
