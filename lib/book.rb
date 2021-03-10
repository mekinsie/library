class Book

attr_accessor :title, :genre, :publish_date, :checkout
attr_reader :id

def intitialize(attributes)
  @title = attributes.fetch(:title)
  @genre = attributes.fetch(:genre)
  @pub_date = attributes.fetch(:publish_date)
  @checkout = attributes.fetch(:checkout)
end

def self.all
  books = []
  returned_books = DB.exec("SELECT * FROM books;")
  returned_books.each do |book|
    title = book.fetch('title')
    genre = book.fetch('genre')
    pub_date = book.fetch('publish_date')
    checkout = book.fetch('checkout')
    id = book.fetch('id').to_i
    books << Book.new({title: title, genre: genre, publish_date: pub_date, checkout: checkout, id: id})
  end
  books
end

end