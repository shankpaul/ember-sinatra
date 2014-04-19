#!/usr/bin/env ruby
# require 'sinatra'
# require 'json'


# get '/' do
# 	content_type :json
#   { :key1 => 'value1', :key2 => 'value2' }.to_json
# end

require "rubygems"
require "sinatra"
require "sinatra/activerecord"
require "sinatra/json"
require 'json'

configure :development do
	Sinatra::Application.reset!
  use Rack::Reloader
end
 
set :database, "sqlite3:contact.db"
 
class Contact < ActiveRecord::Base
	FIELDS_RENDERED = [:id, :name,:address ,:phone,:email,:image]
  	METHODS_RENDERED = []
  	def as_json(options={})
   	 super(:methods => Contact::METHODS_RENDERED, :only => Contact::FIELDS_RENDERED)
  	end
end

get '/' do
	 erb :"contacts/index"
end

get '/contacts' do
	content_type :json	
	json :contacts => Contact.all
end

delete '/contacts/:id' do
	contact = Contact.find(params[:id])
	if contact.destroy
		json :message => "Contact Deleted"	
	else
		json :message => "Contact Not Deleted"	
	end
end

post '/contacts' do
	 params = JSON.parse(request.env["rack.input"].read)	
	 Contact.create(params['contact'])
	 json :message => "Contact Saved"	
end


put '/contacts/:id' do
	id = params[:id]
	params = JSON.parse(request.env["rack.input"].read)	
	contact = Contact.find(id)
	contact.update_attributes(params['contact'])
	json :message => "Contact updatec"	
end
