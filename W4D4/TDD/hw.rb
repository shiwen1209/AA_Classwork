require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef", name: "ur mom") }
  subject(:desert) {Dessert.new("cake", 100, chef)}

  describe "#initialize" do
    it "sets a type" do 
      expect(desert).to be_an_instance_of(Dessert)
    end

    it "sets a quantity" do
      expect(desert.quantity).to be > 0
    end

    it "starts ingredients as an empty array" do
      expect(desert.ingredients).to be_empty
    end

    it "raises an argument error when given a non-integer quantity" do 
      expect {Dessert.new("cake", "bruh", "ur mom")}.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      expect(desert.ingredients).to be_empty
      desert.add_ingredient("flour")
      expect(desert.ingredients[0]).to eq("flour")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do 
      desert.add_ingredient("flour")
      desert.add_ingredient("poop")
      desert.add_ingredient("sugar")
      desert.add_ingredient("milk")
      h = Hash.new(0)
      desert.mix!
      first_ingred = desert.ingredients[0]
      h[first_ingred] += 1
      desert.mix!
      first_ingred = desert.ingredients[0]
      h[first_ingred] += 1
      desert.mix!
      first_ingred = desert.ingredients[0]
      h[first_ingred] += 1
      desert.mix!
      first_ingred = desert.ingredients[0]
      h[first_ingred] += 1
      desert.mix!
      first_ingred = desert.ingredients[0]
      h[first_ingred] += 1
      desert.mix!
      first_ingred = desert.ingredients[0]
      h[first_ingred] += 1
      expect(h.length).to be > 1
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      desert.eat(60)
      expect(desert.quantity).to eq(40)
      desert.eat(40)
      expect(desert.quantity).to eq(0)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect {desert.eat(101)}.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Chef ur mom the Great Baker")
      expect(desert.serve).to include("Chef ur mom the Great Baker")
    end

  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      allow(chef).to receive(:bake)
      desert.make_more
    end
  end
end
