require_relative "../lib/board"

describe Board do
  let(:board) { Board.new }
  describe "#add" do
    it "places a shape on to the board" do
      expect(board.grid).to eql([['-', '-', '-'],
                                ['-', '-', '-'],
                                ['-', '-', '-']])
      board.add("X", 1, 1)
      expect(board.grid).to eql([['-', '-', '-'],
                                ['-', 'X', '-'],
                                ['-', '-', '-']])
    end
    context "With invalid input" do
      it "does not place a shape on to the board when row is out of bounds" do
        expect(board.add("X", 4, 0)).to be false
        expect(board.grid).to eql([['-', '-', '-'],
                                  ['-', '-', '-'],
                                  ['-', '-', '-']])
        expect(board.add("X", -1, 0)).to be false
        expect(board.grid).to eql([['-', '-', '-'],
                                  ['-', '-', '-'],
                                  ['-', '-', '-']])
      end
      it "does not place a shape on to the board when column is out of bounds" do
        expect(board.add("X", 0, 4)).to be false
        expect(board.grid).to eql([['-', '-', '-'],
                                  ['-', '-', '-'],
                                  ['-', '-', '-']])
        expect(board.add("X", 0, -1)).to be false
        expect(board.grid).to eql([['-', '-', '-'],
                                  ['-', '-', '-'],
                                  ['-', '-', '-']])
      end
      it "does not place a shape on to the board if there is already an existing shape at the cell" do
        board.add("X", 0, 0)
        board.add("O", 0, 0)
        expect(board.grid).to eql([['X', '-', '-'],
                                  ['-', '-', '-'],
                                  ['-', '-', '-']])
        board.add("O", 0, 2)
        board.add("X", 0, 2)
        expect(board.grid).to eql([['X', '-', 'O'],
                                  ['-', '-', '-'],
                                  ['-', '-', '-']])
      end
    end
  end
  describe "#check_win_condition" do
    context "Test for 3 in a row win condition" do
      it "returns true when three crosses in a row" do
        board.add("X", 0, 0)
        board.add("X", 0, 1)
        board.add("X", 0, 2)
        expect(board.check_win_condition("X")).to be true
      end

      it "returns true when three noughts in a row" do
        board.add("O", 1, 0)
        board.add("O", 1, 1)
        board.add("O", 1, 2)
        expect(board.check_win_condition("O")).to be true
      end
      it "returns false when three noughts not in a row" do
        board.add("O", 1, 0)
        board.add("O", 1, 1)
        board.add("O", 2, 2)
        expect(board.check_win_condition("O")).to be false
      end
    end
    context "Test for 3 in a column win condition" do
      it "returns true when three crosses in a column" do
        board.add("X", 0, 0)
        board.add("X", 1, 0)
        board.add("X", 2, 0)
        expect(board.check_win_condition("X")).to be true
      end

      it "returns true when three noughts in a column" do
        board.add("O", 0, 2)
        board.add("O", 1, 2)
        board.add("O", 2, 2)
        expect(board.check_win_condition("O")).to be true
      end

      it "returns false when three noughts not in a column" do
        board.add("O", 0, 2)
        board.add("O", 1, 2)
        board.add("O", 2, 3)
        expect(board.check_win_condition("O")).to be false
      end
    end
    context "Test for 3 in a diagonal win condition" do
      it "returns true when three nought in diagonal" do
        board.add("O", 0, 0)
        board.add("O", 1, 1)
        board.add("O", 2, 2)
        expect(board.check_win_condition("O")).to be true

        board2 = Board.new
        board2.add("O", 0, 2)
        board2.add("O", 1, 1)
        board2.add("O", 2, 0)
        expect(board2.check_win_condition("O")).to be true
      end
      it "returns false when three nought not in diagonal" do
        board.add("O", 0, 2)
        board.add("O", 1, 1)
        board.add("O", 2, 2)
        expect(board.check_win_condition("O")).to be false
      end
    end
  end
  describe "#check_draw_condition?" do
    it "returns true when the board is full and no player has won" do
      board.add("O", 0, 0)
      board.add("X", 0, 1)
      board.add("O", 0, 2)
      board.add("X", 1, 0)
      board.add("O", 1, 1)
      board.add("X", 1, 2)
      board.add("X", 2, 0)
      board.add("O", 2, 1)
      board.add("X", 2, 2)
      expect(board.grid).to eql([['O', 'X', 'O'],
                                  ['X', 'O', 'X'],
                                  ['X', 'O', 'X']])
      expect(board.check_win_condition("O")).to be false
      expect(board.check_win_condition("X")).to be false
      expect(board.check_draw_condition).to be true

    end
    it "returns false when there are remaining positions to place shapes on the board" do
      board.add("O", 0, 0)
      board.add("X", 0, 1)
      expect(board.check_draw_condition).to be false
    end
  end
end


# Write tests for each win condition
# 
#
# Write test for draw condition edge case