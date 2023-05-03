
require './person'
require './strategy'
require './strategy2'
require './elevator'
require './GenPeopleFiles'
class Simulation
  def run(filename_string, strategy_symbol)
    GenPeopleFiles.gen_input_files(filename_string, 1, rand(3..8), 0.5, 120, 0.9)
    passengers = []
    filename = "%s%03d.in" % [filename_string, 1]
    file = File.open(filename)
    no_of_floors = file.read(1).to_i
    file.readlines[1..].each() do |line|
      x = line.split(" ")
      passengers << Person.new(x[0],x[1],x[2],x[3])
      file.close
    end
    if(strategy_symbol == :strategy1)
      puts("Starting Strategy 1")
      strategy1 = Strategy1.new
      sim = Elevator.new(no_of_floors, strategy1, passengers)
      sim.run
    elsif(strategy_symbol == :strategy2)
      puts("Starting Strategy 2")
      strategy2 = Strategy2.new
      sim1 = Elevator.new(no_of_floors, strategy2, passengers)
      sim1.run
    end
  end
  def multirun(nbr_runs,filename_prefix,strategy)
    count = 1
    while(count <= nbr_runs)
      GenPeopleFiles.gen_input_files(filename_prefix, nbr_runs, rand(3..8), 0.5, 120, 0.9)
      count += 1
    end
    count = 0
    while(count < nbr_runs)
      puts("\nRun Number: " + (count+1).to_s)
      passengers = []
      filename = "%s%03d.in" % [filename_prefix, count]
      file = File.open(filename)
      no_of_floors = file.read(1).to_i
      file.readlines[1..].each() do |line|
        x = line.split(" ")
        passengers << Person.new(x[0],x[1],x[2],x[3])
        file.close
      end
      if(strategy == :strategy1)
        puts("Starting Strategy 1")
        strategy1 = Strategy1.new
        sim = Elevator.new(no_of_floors, strategy1, passengers)
        sim.run
      elsif(strategy == :strategy2)
        puts("Starting Strategy 2")
        strategy2 = Strategy2.new
        sim1 = Elevator.new(no_of_floors, strategy2, passengers)
        sim1.run
      end
      count += 1
    end
  end
end
def main
  puts("Single Run...")
  sim = Simulation.new
  sim.run("MyInput",:strategy1)
  puts("\nMultiple Runs\n")
  sim.multirun(10,"MyInput",:strategy2)
end
main()