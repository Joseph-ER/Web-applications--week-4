require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  it "returns album details and 200 OK based on album ID" do
    response = get('/albums/1')
    expect(response.status).to eq(200)
    expect(response.body).to include('Doolittle')

  end

  it "returns all albums and 200 OK" do
    response = get('/albums')
    expect(response.status).to eq(200)
    expect(response.body).to include ('<p> Title: Doolittle, Release year 1989</p>')
    expect(response.body).to include ('<p> Title: Waterloo')
  end

  it "returns all artiss and returns 200 OK" do
    response = get('/artists')
    expect(response.status).to eq(200)
    expect(response.body).to include('ABBA')
    expect(response.body).to include('Pixies')
    expect(response.body).to include('Pop')

  end

  it "returns artist by their ID " do
    response = get('/artists/2')
    expect(response.status).to eq(200)
    expect(response.body).to include('ABBA')

  end


end
