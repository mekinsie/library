class Book
  attr_accessor :title, :genre
  attr_reader :id

  def initialize(attributes)
    @title = attributes[:title]
    @genre = attributes[:genre]
    @id = attributes[:id]
  end

  def self.all
    books = []
    returned_books = DB.exec("SELECT * FROM books;")
    returned_books.each do |book|
      title = book.fetch('title')
      genre = book.fetch('genre')
      id = book.fetch('id').to_i
      books << Book.new({title: title, genre: genre, id: id})
    end
    books
  end


def save

end

end
