require 'spec_helper'

describe '#Book' do

#   before(:each) do
#   end

  describe('.all') do
    it("returns an empty array when there are no books") do
      expect(Book.all).to(eq([]))
    end
  end

end
