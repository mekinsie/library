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

end