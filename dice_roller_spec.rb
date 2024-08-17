require 'rspec'
require_relative 'dice_roller'

RSpec.describe Dice do
  it 'rolls a die with the correct number of sides' do
    die = Dice.new(6)
    100.times do
      result = die.roll
      expect(result).to be_between(1, 6)
    end
  end

  it 'raises an error if the number of sides is less than or equal to zero' do
    expect { Dice.new(0) }.to raise_error(ArgumentError)
    expect { Dice.new(-1) }.to raise_error(ArgumentError)
  end
end

RSpec.describe DiceRoller do
  it 'rolls multiple dice and returns the correct result' do
    dice = [Dice.new(6), Dice.new(8)]
    roller = DiceRoller.new(dice)
    result = roller.roll_all

    expect(result.values.size).to eq(dice.size)
    expect(result.total).to eq(result.values.sum)
    expect(result.description).to include('Rolled:')
    expect(result.description).to include('Total:')
  end

  it 'raises an error if dice is not an array' do
    expect { DiceRoller.new('invalid') }.to raise_error(ArgumentError)
  end
end

RSpec.describe RollResult do
  it 'creates a result with the correct description' do
    dice = [Dice.new(6), Dice.new(8)]
    values = [3, 5]
    total = values.sum
    result = RollResult.new(dice, values, total)

    expect(result.description).to include('Die 1 (6-sided): 3')
    expect(result.description).to include('Die 2 (8-sided): 5')
    expect(result.description).to include("Total: #{total}")
  end
end
