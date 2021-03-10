require('sinatra')
require('sinatra/reloader')
require('./lib/book')
require('pry')
require('pg')
also_reload('lib/**/*.rb')
DB = PG.connect({:dbname => "library", :password => 'bean'})


get('/')do
  redirect to ('/books')
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
