require './lib/knights.rb'

  describe "#knights_travail" do
    it "path test 1" do
      actual = knight_moves([0,0],[1,2])
      expected = [[0,0],[1,2]]

      expect(actual).to eql(expected)
    end

    it "path test 2" do
      actual = knight_moves([0,0],[3,3])
      expected1 = [[0,0],[2,1],[3,3]] 
      expected2 = [[0,0],[1,2],[3,3]]

      expect(actual).to eql(expected1).or(eql(expected2))
    end

    it "path test 3" do
      actual = knight_moves([3,3],[0,0])
      expected1 = [[3,3],[2,1],[0,0]]
      expected2 = [[3,3],[1,2],[0,0]]

      expect(actual).to eql(expected1).or(eql(expected2))
    end

    it "path test 4" do
      actual = knight_moves([0,0],[7,7])
      expected1 = [[0,0],[2,1],[4,2],[6,3],[4,4],[6,5],[7,7]]
      expected2 = [[0,0],[2,1],[4,2],[6,3],[7,5],[5,6],[7,7]]

      expect(actual).to eql(expected1).or(eql(expected2))
    end

    it "path test 5" do
      actual = knight_moves([3,3],[4,3])
      expected1 = [[3,3],[4,5],[2,4],[4,3]]
      expected2 = [[3,3],[4,5],[6,4],[4,3]]

      expect(actual).to eql(expected1).or(eql(expected2))
    end
  end