class Book

attr_accessor :title, :genre, :publish_date, :check_out
attr_reader :id

def intitialize(attributes)
  @title = attributes.fetch(:title)
  @genre = attributes.fetch(:genre)
  @publish_date = attributes.fetch(:publish_date)
  @checkout = attributes.fetch(:check_out)
end

def self.all 

end

end