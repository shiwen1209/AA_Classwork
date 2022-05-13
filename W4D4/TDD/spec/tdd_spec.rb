require "tdd"

describe "Array#my_uniq" do
    let(:arr) {[1, 2, 1, 3, 3]}

    it "should properly remove all duplicate elements" do
        expect(arr.my_uniq.length).to eq(3)
    end

    it "should be in the original order" do 
        expect(arr.my_uniq).to eq([1,2,3])
    end

    it "should return a new array" do 
        expect(arr.my_uniq).to_not be(arr)
    end
end

describe "Array#two_sum" do
    let(:arr) {[-1,0,2,-2,1]}

    it "finds all pairs of positions where the elements at those positions sum to zero" do
        expect(arr.two_sum).to include([0,4])
        expect(arr.two_sum).to include([2,3])
        expect(arr.two_sum.length).to eq(2)
    end

    it "each of the pairs to be sorted smaller index before bigger index" do 
        expect(arr.two_sum).to eq([[0,4],[2,3]])
    end
end

describe "Array#my_transpose" do
    let(:arr) { [[0, 1, 2],[3, 4, 5], [6, 7, 8]] }

    it "doesn't change dimensions of the 2-d Array" do
        expect(arr.my_transpose.length).to eq 3
        expect(arr.my_transpose[0].length).to eq 3
    end

    it "properly transposes the array" do
        expect(arr.my_transpose).to eq([[0, 3, 6],[1, 4, 7],[2, 5, 8]])
    end

    it "returns a new array and does not modify original" do
        expect(arr.my_transpose).to_not be(arr)

    end
end

describe "#stockpicker" do 
    let(:prices) {[7,1,5,3,6,4]}

    it "should return array of two indices for the input arr" do 
        expect(stockpicker(prices).length).to eq(2)
    end

    it "should ensure the buy date is less than sell date" do
        result = stockpicker(prices)
        expect(result[0]).to be < result[1]
    end 
    
    it "should return the index of positions result in highest profit" do
        expect(stockpicker(prices)).to eq([1,4]) 
    end

    it "should empty array if there're no profitbale transactions" do 
        expect(stockpicker([7,6,4,3,1])).to eq([])
    end
end

describe Hanoi do
    let(:hanoi) {Hanoi.new(4)}

    describe "#initialize" do
        it "should properly initalize hanoi game" do
            expect(hanoi.towers.length).to eq(3)
            expect(hanoi.towers[0].length).to be > 0
            expect(hanoi.towers[1]).to be_empty
            expect(hanoi.towers[2]).to be_empty
            expect(hanoi.towers[0]).to eq([4,3,2,1])
        end
    end



    describe "#move" do
        context "should allow user to move stacks around" do
            let(:hanoi1) do
                h1 = Hanoi.new(4)
                h1.towers = [
                    [4,3,2],
                    [],
                    [1]]
                h1
            end

            it "raise and error if the input index are out of bound" do 
                expect{hanoi1.move(4,0)}.to raise_error(IOError)
            end 

            it "raise and error if the move_from tower is empty" do 
                expect{hanoi1.move(1,0)}.to raise_error(IOError)
            end 
            
                it "should allow user move pieces freely into empty piles" do 
                expect(hanoi1.move(0, 1)).to eq(true)
                expect(hanoi1.towers).to eq([[4,3],[2],[1]])
            end 

            it "should allow user move pieces freely into empty piles" do 
                expect(hanoi1.move(2, 0)).to eq(true)
                expect(hanoi1.towers).to eq([[4,3,2,1],[],[]])
            end 
            
            it "return false when the piece tryig to move is larger than the piece on top of the destination" do 
                expect(hanoi1.move(0, 2)).to eq(false)
                expect(hanoi1.towers).to eq([[4,3,2],[],[1]])
            end
        end 
    end

    describe "#won?" do
        it "returns true when the all pieces are on the last board" do
            hanoi.towers[2] = hanoi.towers[0].dup
            hanoi.towers[0] = []
            expect(hanoi.won?).to eq(true)

        end
            

        it "returns false when otherwise" do 
            expect(hanoi.won?).to eq(false)
            hanoi.towers[1] = hanoi.towers[0].dup
            hanoi.towers[0] = []
            expect(hanoi.won?).to eq(false)
        end
    end



end