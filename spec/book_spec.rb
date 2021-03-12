require 'spec_helper'

describe '#Book' do

  before(:each) do
  end

  describe('.all') do
    it("returns an empty array when there are no books") do
      expect(Book.all).to(eq([]))
    end
  end

  describe('#==') do
    it('should check to see if two books are the same') do
    book1 = Book.new({:title => "Sapiens", :genre => "non-fiction", :id => nil})
    book1.save()
    book2 = Book.new({:title => "Sapiens", :genre => "non-fiction", :id => nil})
    book2.save()
    expect(book1).to(eq(book2))
  end
end

  describe('#save') do
    it('should save a new book into the database') do
    book1 = Book.new({:title => "Sapiens", :genre => "non-fiction", :id => nil})
    book1.save()
    book2 = Book.new({:title => "The Road", :genre => "fiction", :id => nil})
    book2.save()
    expect(Book.all).to(eq([book1, book2]))
  end
end

  describe('.find') do
    it('should find a book by id') do
    book1 = Book.new({:title => "Sapiens", :genre => "non-fiction", :id => nil})
    book1.save()
    book2 = Book.new({:title => "The Road", :genre => "fiction", :id => nil})
    book2.save()
    expect(Book.find(book1.id)).to(eq(book1))
    end
  end

  describe('#update') do
    it('should update a book title') do
    book1 = Book.new({:title => "Sapiens", :genre => "non-fiction", :id => nil})
    book1.save()
    book1.update({:title => "Homo Sapiens"})
    expect(book1.title).to(eq("Homo Sapiens"))
    end

    it('should update the book title and genre') do
    book2 = Book.new({:title => "The Road", :genre => "fiction", :id => nil})
    book2.save()
    book2.update({:title => "Sapiens", :genre => "non-fiction"})
    expect(book2.title).to(eq("Sapiens"))
    expect(book2.genre).to(eq("non-fiction"))
    end
  end

  describe('#delete') do
    it('deletes a book') do
    book1 = Book.new({:title => "Sapiens", :genre => "non-fiction", :id => nil})
    book1.save()
    book2 = Book.new({:title => "The Road", :genre => "fiction", :id => nil})
    book2.save()
    book1.delete()
    expect(Book.all).to(eq([book2]))
    end
  end

  describe('#authors') do
    it("should return an empty array if no authors belong to the book") do
      book1 = Book.new({:title => "Sapiens", :genre => "non-fiction", :id => nil})
      book1.save()
      expect(book1.authors).to(eq([]))
    end
  end

  describe('#add_author') do
    it('should add an author to a book') do
      author1 = Author.new({:first_name => "Noah", :last_name => "Hararri", :id => nil})
      author1.save()
      book1 = Book.new({:title => "Sapiens", :genre => "non-fiction", :id => nil})
      book1.save()
      book1.add_author({:first_name => "Noah", :last_name => "Hararri"})
      expect(book1.authors).to(eq([author1]))
    end
  end



end