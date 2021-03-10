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

  def ==(book_to_compare)
    if book_to_compare != nil
      (self.title == book_to_compare.title)
    else
      false
    end
  end

  def save
    result = DB.exec("INSERT INTO books (title, genre) VALUES ('#{@title}', '#{@genre}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def self.find(id)
    book = DB.exec("SELECT * FROM books WHERE id = #{id};").first
    title = book.fetch("title")
    genre = book.fetch("genre")
    id = book.fetch("id")
    Book.new({title: title, genre: genre, id: id})
  end


  def update(attributes)
    
  end

end
