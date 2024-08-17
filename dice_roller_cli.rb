require_relative 'dice_roller'

# Parses command-line arguments to create dice objects
# @return [Array<Dice>] An array of Dice objects based on command-line arguments
def parse_args
  dice = []
  ARGV.each_slice(2) do |sides, count|
    begin
      sides = sides.to_i
      count = count.to_i
      raise ArgumentError, 'Number of sides and count must be positive integers' if sides <= 0 || count <= 0
      dice.concat(Array.new(count) { Dice.new(sides) })
    rescue ArgumentError => e
      puts "Error: #{e.message}"
      exit
    end
  end
  dice
end

# Main entry point for the CLI program
def main
  if ARGV.empty?
    puts "Usage: ruby dice_roller_cli.rb <sides1> <count1> [<sides2> <count2> ...]"
    puts "Example: ruby dice_roller_cli.rb 6 2 8 1"
    puts "This rolls 2 six-sided dice and 1 eight-sided die."
    return
  end

  dice = parse_args
  if dice.empty?
    puts "No valid dice specified."
    return
  end

  roller = DiceRoller.new(dice)
  result = roller.roll_all
  puts result.description
end

main if __FILE__ == $PROGRAM_NAME
