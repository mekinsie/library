require 'spec_helper'

describe '#Patron' do
  describe('.all') do
    it("returns an empty array when there are no patrons") do
      expect(Patron.all).to(eq([]))
    end
  end

  describe('#==') do
    it('should check to see if two patrons are the same') do
    patron1 = Patron.new({:first_name => "Noah", :last_name => "Harrari", :id => nil})
    patron1.save()
    patron2 = Patron.new({:first_name => "Noah", :last_name => "Harrari", :id => nil})
    patron2.save()
    expect(patron1).to(eq(patron2))
    end
  end

  describe('#save') do
    it('should save a new patron into the database') do
    patron1 = Patron.new({:first_name => "Noah", :last_name => "Harrari", :id => nil})
    patron1.save()
    patron2 = Patron.new({:first_name => "Stephanie", :last_name => "Meyer", :id => nil})
    patron2.save()
    expect(Patron.all).to(eq([patron1, patron2]))
    end
  end

  describe('.find') do
    it('should find a patron by id') do
    patron1 = Patron.new({:first_name => "Noah", :last_name => "Harrari", :id => nil})
    patron1.save()
    patron2 = Patron.new({:first_name => "Stephanie", :last_name => "Meyer", :id => nil})
    patron2.save()
    expect(Patron.find(patron1.id)).to(eq(patron1))
    end
  end

  describe('#update') do
    it('should update a patron first_name') do
    patron1 = Patron.new({:first_name => "Noah", :last_name => "Harrari", :id => nil})
    patron1.save()
    patron1.update({:first_name => "Yuval"})
    expect(patron1.first_name).to(eq("Yuval"))
    end

    it('should update a patron last_name') do
      patron1 = Patron.new({:first_name => "Noah", :last_name => "Harrari", :id => nil})
      patron1.save()
      patron1.update({:last_name => "Different"})
      expect(patron1.last_name).to(eq("Different"))
      end
    end

  describe('#delete') do
    it('deletes a patron') do
    patron1 = Patron.new({:first_name => "Noah", :last_name => "Harrari", :id => nil})
    patron1.save()
    patron2 = Patron.new({:first_name => "Stephanie", :last_name => "Meyer", :id => nil})
    patron2.save()
    patron1.delete()
    expect(Patron.all).to(eq([patron2]))
    end
  end
end