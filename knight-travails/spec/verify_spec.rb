require './lib/verify'

RSpec.describe Validation do
  describe "#valid_point" do
    it "enter a string" do
      actual = Validation.valid_point?("5")
      expected = false

      expect(actual).to eql(expected)
    end

    it "enter random number between 0 and 7" do
      actual = Validation.valid_point?(rand(0..7))
      expected = true

      expect(actual).to eql(expected)
    end

    it "enter negative number" do
      actual = Validation.valid_point?(-5)
      expected = false

      expect(actual).to eql(expected)
    end
  end

  describe "#valid_coordinate" do
    it "enter empty coordinate" do
      actual = Validation.valid_coordinate?([])
      expected = false

      expect(actual).to eql(expected)
    end

    it "enter 1D coordinate" do
      actual = Validation.valid_coordinate?([5])
      expected = false

      expect(actual).to eql(expected)
    end

    it "enter normal coordinate" do
      actual = Validation.valid_coordinate?([2,5])
      expected = true

      expect(actual).to eql(expected)
    end

    it "enter wrong coordinate" do
      actual = Validation.valid_coordinate?([8, 4])
      expected = false

      expect(actual).to eql(expected)
    end

    it "enter 3D coordinate" do
      actual = Validation.valid_coordinate?([1,2,3])
      expected = false

      expect(actual).to eql(expected)
    end

    it "enter coordinate of string points" do
      actual = Validation.valid_coordinate?(["4", "5"])
      expected = false

      expect(actual).to eql(expected)
    end

    it "enter string coordinate" do
      actual = Validation.valid_coordinate?("[4,5]")
      expected = false

      expect(actual).to eql(expected)
    end
  end
end