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
end