require 'rspec'
require 'pg'
require 'pry'
require 'book'
require 'author'
require 'patron'

DB = PG.connect({:dbname => 'library_test', :password => 'bean'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM authors *;")
    DB.exec("DELETE FROM patrons *;")
    DB.exec("DELETE FROM checkouts *;")
  end
end

