class Patron
  attr_accessor :first_name, :last_name
  attr_reader :id

  def initialize(attributes)
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @id = attributes[:id]
  end

  def self.all
    patrons = []
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    returned_patrons.each do |patron|
      first_name = patron.fetch('first_name')
      last_name = patron.fetch('last_name')
      id = patron.fetch('id').to_i
      patrons << Patron.new({first_name: first_name, last_name: last_name, id: id})
    end
    patrons
  end

  def ==(patron_to_compare)
    if patron_to_compare != nil
      (self.first_name == patron_to_compare.first_name && self.last_name == patron_to_compare.last_name)
    else
      false
    end
  end

  def save
    result = DB.exec("INSERT INTO patrons (first_name, last_name) VALUES ('#{@first_name}', '#{@last_name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def self.find(id)
    patron = DB.exec("SELECT * FROM patrons WHERE id = #{id};").first
    if patron != nil
      first_name = patron.fetch("first_name")
      last_name = patron.fetch("last_name")
      id = patron.fetch("id")
      Patron.new({first_name: first_name, last_name: last_name, id: id})
    end
  end

  def update(attributes)
    if (attributes.has_key?(:first_name)) && (attributes.fetch(:first_name) != nil)
      @first_name = attributes.fetch(:first_name)
      DB.exec("UPDATE patrons SET first_name = '#{@first_name}' WHERE id = #{@id};")
    end
    if (attributes.has_key?(:last_name)) && (attributes.fetch(:last_name) != nil)
      @last_name = attributes.fetch(:last_name)
      DB.exec("UPDATE patrons SET last_name = '#{@last_name}' WHERE id = #{@id};")
    end
  end

  def checkouts
    checkouts = []
    books_out = DB.exec("SELECT book_id FROM checkouts WHERE patron_id = #{@id};")
    books_out.each() do |result|
      book_id = result.fetch("book_id").to_i()
      book = DB.exec("SELECT * FROM books WHERE id = #{book_id};")
      title = book.first().fetch("title")
      genre = book.first().fetch("genre")
      checkouts << (Book.new({:title => title, :genre => genre, :id => book_id}))
    end
    checkouts
  end

  def checkout_book(book_info)
    @title = book_info.fetch(:title)
    @genre = book_info.fetch(:genre)
    book = DB.exec("SELECT * FROM books WHERE (lower(title) = '#{@title.downcase}' AND lower(genre) = '#{@genre.downcase}');").first
    if book != nil
      DB.exec("INSERT INTO checkouts (book_id, patron_id, checkout_date, return_date) VALUES (#{book['id'].to_i}, #{@id}, CURRENT_DATE, CURRENT_DATE + INTERVAL '14 day');")
    end
  end

  def delete
    DB.exec("DELETE FROM patrons WHERE id = #{@id};")
    DB.exec("DELETE FROM checkouts WHERE patron_id = #{@id};")
  end
end
