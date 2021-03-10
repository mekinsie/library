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

end