class Author
  attr_accessor :first_name, :last_name
  attr_reader :id

  def initialize(attributes)
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @id = attributes[:id]
  end

  def self.all
    authors = []
    returned_authors = DB.exec("SELECT * FROM authors;")
    returned_authors.each do |author|
      first_name = author.fetch('first_name')
      last_name = author.fetch('last_name')
      id = author.fetch('id').to_i
      authors << Author.new({first_name: first_name, last_name: last_name, id: id})
    end
    authors
  end

  def ==(author_to_compare)
    if author_to_compare != nil
      (self.first_name == author_to_compare.first_name && self.last_name == author_to_compare.last_name)
    else
      false
    end
  end

  def save
    result = DB.exec("INSERT INTO authors (first_name, last_name) VALUES ('#{@first_name}', '#{@last_name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def self.find(id)
    author = DB.exec("SELECT * FROM authors WHERE id = #{id};").first
    if author != nil
      first_name = author.fetch("first_name")
      last_name = author.fetch("last_name")
      id = author.fetch("id")
      Author.new({first_name: first_name, last_name: last_name, id: id})
    end
  end

  def update(attributes)
    if (attributes.has_key?(:first_name)) && (attributes.fetch(:first_name) != nil)
      @first_name = attributes.fetch(:first_name)
      DB.exec("UPDATE authors SET first_name = '#{@first_name}' WHERE id = #{@id};")
    end
    if (attributes.has_key?(:last_name)) && (attributes.fetch(:last_name) != nil)
      @last_name = attributes.fetch(:last_name)
      DB.exec("UPDATE authors SET last_name = '#{@last_name}' WHERE id = #{@id};")
    end
  end

  def books
    books = []
    results = DB.exec("SELECT book_id FROM authors_books WHERE author_id = #{@id};")
    results.each() do |result|
      book_id = result.fetch("book_id").to_i()
      book = DB.exec("SELECT * FROM books WHERE id = #{book_id};")
      title = book.first().fetch("title")
      genre = book.first().fetch("genre")
      books << (Book.new({:title => title, :genre => genre, :id => book_id}))
    end
    books
  end

  def add_book(book_info)
    @title = book_info.fetch(:title)
    @genre = book_info.fetch(:genre)
    book = DB.exec("SELECT * FROM books WHERE (lower(title) = '#{@title.downcase}' AND lower(genre) = '#{@genre.downcase}');").first
    if book != nil
      DB.exec("INSERT INTO authors_books (book_id, author_id) VALUES (#{book['id'].to_i}, #{@id});")
    end
  end

  def delete
    DB.exec("DELETE FROM authors WHERE id = #{@id};")
  end
end
