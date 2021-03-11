require('sinatra')
require('sinatra/reloader')
require('./lib/book')
require('./lib/author')
require('./lib/patron')
require('pry')
require('pg')
also_reload('lib/**/*.rb')
DB = PG.connect({:dbname => "library", :password => 'bean'})


get('/')do

  erb(:home)
end

#=========
#Authors
#=========

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
  @books = @author.books
  erb(:author)
end


patch('/authors/:id') do
  @author = Author.find(params[:id])
  @author.update({:last_name => params[:last_name], :first_name => params[:first_name]})
  if params[:title] != nil
    title = params[:title]
    genre = params[:genre]
    @author.add_book({:title => title, :genre => genre})
  end
  @books = @author.books
  erb(:author)
end

delete('/authors/:id')do
  Author.find(params[:id]).delete
  @authors = Author.all
  erb(:authors)
end

#=========
#Books
#=========

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
  @authors = @book.authors
  erb(:book)
end

patch('/books/:id') do
  @book = Book.find(params[:id])
  @book.update({:title => params[:title], :genre => params[:genre]})
  if params[:first_name] != nil
    first_name = params[:first_name]
    last_name = params[:last_name]
    @book.add_author({:first_name => first_name, :last_name => last_name})
  end
  @authors = @book.authors
  erb(:book)
end

delete('/books/:id')do
  Book.find(params[:id]).delete
  @books = Book.all
  erb(:books)
end

get('/books/:id/author') do
  # @book = Book.find(params[:id])
  erb(:author)
end

#=========
#Patrons
#=========

get('/patrons') do
  @patrons = Patron.all
  erb(:patrons)
end

post('/patrons') do
  patron = Patron.new({:first_name => params[:first_name], :last_name => params[:last_name], :id => nil})
  patron.save
  @patrons = Patron.all
  erb(:patrons)
end

get('/patrons/:id') do
  @patron = Patron.find(params[:id])
  erb(:patron)
end

patch('/patrons/:id') do
  @patron = Patron.find(params[:id])
  @patron.update({:last_name => params[:last_name], :first_name => params[:first_name]})
  erb(:patron)
end

delete('/patrons/:id')do
  Patron.find(params[:id]).delete
  @patrons = Author.all
  erb(:patrons)
end