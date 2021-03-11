require('sinatra')
require('sinatra/reloader')
require('./lib/book')
require('./lib/author')
require('pry')
require('pg')
also_reload('lib/**/*.rb')
DB = PG.connect({:dbname => "library", :password => 'bean'})


get('/')do

  erb(:home)
end

get('/authors') do
  @authors = Author.all
  erb(:authors)
end

post('/authors') do
  author = Author.new({:first_name => params[:first_name], :last_name => params[:last_name], :id => nil})
  author.save
  @authors = Author.all
  erb(:authors)
end

get('/authors/:id') do
  @author = Author.find(params[:id])
  erb(:author)
end


patch('/authors/:id') do
  @author = Author.find(params[:id])
  @author.update({:last_name => params[:last_name], :first_name => params[:first_name]})
  erb(:author)
end

get('/books') do
  @books = Book.all
  erb(:books)
end

post('/books') do
  book = Book.new({:title => params[:title], :genre => params[:genre], :id => nil})
  book.save
  @books = Book.all
  erb(:books)
end

get('/books/:id') do
  @book = Book.find(params[:id])
  erb(:book)
end

patch('/books/:id') do
  @book = Book.find(params[:id])
  @book.update({:title => params[:title], :genre => params[:genre]})
  erb(:book)
end

delete('/books/:id')do

  erb(:books)
end

get('/books/:id/author') do
  # @book = Book.find(params[:id])
  erb(:author)
end