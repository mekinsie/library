require 'spec_helper'

describe '#Author' do

  # before(:each) do
  # end

  describe('.all') do
    it("returns an empty array when there are no authors") do
      expect(Author.all).to(eq([]))
    end
  end

  describe('#==') do
    it('should check to see if two authors are the same') do
    author1 = Author.new({:first_name => "Noah", :last_name => "Harrari", :id => nil})
    author1.save()
    author2 = Author.new({:first_name => "Noah", :last_name => "Harrari", :id => nil})
    author2.save()
    expect(author1).to(eq(author2))
    end
  end

  describe('#save') do
    it('should save a new author into the database') do
    author1 = Author.new({:first_name => "Noah", :last_name => "Harrari", :id => nil})
    author1.save()
    author2 = Author.new({:first_name => "Stephanie", :last_name => "Meyer", :id => nil})
    author2.save()
    expect(Author.all).to(eq([author1, author2]))
    end
  end

  describe('.find') do
    it('should find a author by id') do
    author1 = Author.new({:first_name => "Noah", :last_name => "Harrari", :id => nil})
    author1.save()
    author2 = Author.new({:first_name => "Stephanie", :last_name => "Meyer", :id => nil})
    author2.save()
    expect(Author.find(author1.id)).to(eq(author1))
    end
  end

  describe('#update') do
    it('should update a author first_name') do
    author1 = Author.new({:first_name => "Noah", :last_name => "Harrari", :id => nil})
    author1.save()
    author1.update({:first_name => "Homo Noah"})
    expect(author1.first_name).to(eq("Homo Noah"))
    end

    it('should update the author first_name and last_name') do
    author2 = Author.new({:first_name => "Stephanie", :last_name => "Meyer", :id => nil})
    author2.save()
    author2.update({:first_name => "Noah", :last_name => "Harrari"})
    expect(author2.first_name).to(eq("Noah"))
    expect(author2.last_name).to(eq("Harrari"))
    end
  end

  describe('#delete') do
    it('deletes a author') do
    author1 = Author.new({:first_name => "Noah", :last_name => "Harrari", :id => nil})
    author1.save()
    author2 = Author.new({:first_name => "Stephanie", :last_name => "Meyer", :id => nil})
    author2.save()
    author1.delete()
    expect(Author.all).to(eq([author2]))
    end
  end

  describe('#books') do
    it("should return an empty array if no books belong to the author") do
      author1 = Author.new({:first_name => "Noah", :last_name => "Hararri", :id => nil})
      author1.save()
      expect(author1.books).to(eq([]))
    end
  end

  describe('#add_book') do
    it('should add an a book to an author') do
      author1 = Author.new({:first_name => "Noah", :last_name => "Hararri", :id => nil})
      author1.save()
      book1 = Book.new({:title => "Sapiens", :genre => "non-fiction", :id => nil})
      book1.save()
      author1.add_book({:title => "Sapiens", :genre => "non-fiction"})
      expect(author1.books).to(eq([book1]))
    end
  end
end