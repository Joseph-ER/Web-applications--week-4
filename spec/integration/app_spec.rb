require 'spec_helper'
require 'rack/test'
require_relative '../../app'

describe Application do 
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }
  context "POST /" do
    it "returns 200 OK" do
      response = post("/")
      expect(response.status).to eq(200)
    end
  end

  context "Route http://localhost:9292/sort-names" do
    it "returns 200 OK when /sort" do 
      response = post("/sort", names: ['Joe','Alice','Zoe','Julia','Kieran'])
      expect(response.status).to eq(200)
    end

    it "returns alphabetical list of strings in 'names' " do
      response = post("sort", names: ['Joe','Alice','Zoe','Julia','Kieran'])
      expect(response.status).to eq(200)
      expect(response.body).to eq('Alice,Joe,Julia,Kieran,Zoe')
    end
  end
end