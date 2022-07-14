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
    expect(response.body).to include('<a href="/albums/3">Go to the about page</a>')
  end

  it "returns all artists and returns 200 OK" do
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

  context "POST/albums" do
    it "should validate album parameters" do
      response = post("/albums", invalid_artist_title: 'Ok Computer', another_invalid_thing: 123)
      expect(response.status).to eq(400)
    end

    it "returns empty string" do
      response = post("/albums")
      expect(response.status).to eq(200)
      expect(response.body).to include(" ")
    end
  end

  context "GET/albums/new" do
    it "should return a form to add a new  album" do
      response = get('/albums/new')
      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/albums">')
      expect(response.body).to include('input type="text" name="title" />')
      expect(response.body).to include('input type="text" name="release_year" />')
      expect(response.body).to include('input type="text" name="artist_id" />')
    end
  end

end