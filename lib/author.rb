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

  def delete
    DB.exec("DELETE FROM authors WHERE id = #{@id};")
  end
end
