# Represents a single die with a given number of sides
class Dice
    # Initializes the die with a specific number of sides
    # @param sides [Integer] The number of sides on the die
    # @raise [ArgumentError] if the number of sides is less than or equal to 0
    def initialize(sides)
      raise ArgumentError, 'Number of sides must be greater than 0' if sides <= 0
      @sides = sides
    end
  
    # Rolls the die and returns a random value between 1 and the number of sides
    # @return [Integer] A random value between 1 and the number of sides
    def roll
      rand(1..@sides)
    end
  
    # Returns the number of sides on the die
    # @return [Integer] The number of sides on the die
    def sides
      @sides
    end
  end
  
  # Manages a collection of dice and handles rolling them
  class DiceRoller
    # Initializes the dice roller with a collection of dice
    # @param dice [Array<Dice>] An array of Dice objects
    # @raise [ArgumentError] if the dice parameter is not an array
    def initialize(dice)
      raise ArgumentError, 'Dice must be an array' unless dice.is_a?(Array)
      @dice = dice
    end
  
    # Rolls all dice and returns a RollResult object with the results
    # @return [RollResult] The result of rolling all dice
    def roll_all
      results = @dice.map(&:roll)
      total = results.sum
      RollResult.new(@dice, results, total)
    end
  end
  
  # Represents the outcome of rolling a set of dice
  class RollResult
    attr_reader :dice, :values, :total
  
    # Initializes the roll result with dice, their values, and the total value
    # @param dice [Array<Dice>] The dice that were rolled
    # @param values [Array<Integer>] The results of rolling each die
    # @param total [Integer] The sum of all die roll results
    def initialize(dice, values, total)
      @dice = dice
      @values = values
      @total = total
    end
  
    # Provides a description of the roll result
    # @return [String] A string describing the dice rolled and their results
    def description
      dice_descriptions = dice.each_with_index.map do |die, index|
        "Die #{index + 1} (#{die.sides}-sided): #{values[index]}"
      end
      "Rolled: #{dice_descriptions.join(', ')}. Total: #{total}"
    end
  end
  