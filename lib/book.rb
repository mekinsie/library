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
    if book != nil
      title = book.fetch("title")
      genre = book.fetch("genre")
      id = book.fetch("id")
      Book.new({title: title, genre: genre, id: id})
    end
  end

  def update(attributes)
    if (attributes.has_key?(:title)) && (attributes.fetch(:title) != nil)
      @title = attributes.fetch(:title)
      DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{@id};")
    end
    if (attributes.has_key?(:genre)) && (attributes.fetch(:genre) != nil)
      @genre = attributes.fetch(:genre)
      DB.exec("UPDATE books SET genre = '#{@genre}' WHERE id = #{@id};")
    end
  end

  def authors
    authors = []
    results = DB.exec("SELECT author_id FROM authors_books WHERE book_id = #{@id};")
    results.each() do |result|
      author_id = results.fetch("author_id").to_i
      author = DB.exec("SELECT * FROM authors WHERE id = #{author_id};")
      last_name = author.first().fetch("last_name")
      first_name = author.first().fetch("first_name")
      authors << (Author.new({:first_name => first_name, :last_name => last_name, :id => author_id}))
    end
    authors
  end

  def add_author(author_name)
    # author = DB.exec("SELECT * FROM authors WHERE lower(name) = '#{author_name.downcase}';").first
    # if author != nil
    #   DB.exec("INSERT INTO authors_books (author_id, book_id) VALUES (#{author['id'].to_i}, #{@id});")
    # end
  end


  def delete
    DB.exec("DELETE FROM books WHERE id = #{@id};")
  end
end
