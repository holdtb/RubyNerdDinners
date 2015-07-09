require 'rubygems'
require 'sinatra/base'
require 'sinatra/reloader'
require 'mongo_mapper'
require_relative 'model/rsvp'
require_relative 'model/dinner'
require 'chronic'
require 'date'

class NerdDinner < Sinatra::Base
  configure do
    MongoMapper.connection = Mongo::Connection.new("localhost", 27017)
    MongoMapper.database = "dinners"
  end

  get '/' do
    initial_date = Time.new
    @dinners = Dinner.where(:event_date => {:$gte => initial_date})
    if @dinners.count > 0
      erb :index
    else
      erb :no_upcoming_dinners
    end
  end

  get '/create' do
    erb :create
  end

  post '/create' do
    Dinner.create!(:title => params[:title_input],
       :event_date => Chronic.parse(params[:event_date_input]),
       :description => params[:description_input],
       :hosted_by => params[:hosted_by_input],
       :contact_phone => params[:contact_phone_input],
       :address => params[:address_input],
       :country => params[:country_input])
     redirect '/'
  end

  get '/details/:id' do
    @dinner = Dinner.find(params[:id])
    @attendees = RSVP.where(:dinner_id => @dinner[:_id])
    @attendees.each do |att|
      puts att.attendee_name
    end
    puts @attendees.class
    puts @attendees
    if @dinner.nil?
      erb :not_found
    else
      erb :details
    end
  end

  get '/delete/:id' do
    @dinner = Dinner.find(params[:id])
    if @dinner.nil?
      erb :not_found
    else
      erb :delete
    end
  end

  post '/delete/:id' do
    if params.has_key?("ok")
      Dinner.remove({:_id => BSON::ObjectId(params[:id])})
      redirect '/'
    else
      redirect '/'
    end
  end

  get '/edit/:id' do
    @dinner = Dinner.find(params[:id])
    erb :edit
  end

  post '/edit/:id' do
    @dinner = Dinner.find(params[:id])
    @dinner.update_attributes(:title => params[:title_input],
         :event_date => Chronic.parse(params[:event_date_input]),
         :description => params[:description_input],
         :hosted_by => params[:hosted_by_input],
         :contact_phone => params[:contact_phone_input],
         :address => params[:address_input],
         :country => params[:country_input])
    @dinner.save
    redirect "/details/#{params[:id]}"
  end

  get '/rsvp/:id' do
    @id = params[:id]
    erb :rsvp
  end

  post '/rsvp/:id' do
    @dinner = Dinner.find(params[:id])
    RSVP.create!(
      :attendee_name => params[:attendee_name],
      :dinner => @dinner)
    redirect "/details/#{params[:id]}"
  end


end
