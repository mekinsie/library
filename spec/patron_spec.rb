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
end