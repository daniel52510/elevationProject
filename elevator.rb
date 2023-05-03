# frozen_string_literal: true
require './person'
require './strategy'
require './strategy2'

class Elevator
  def initialize(max_floors, strategy, passengers)
    @@top_floor = max_floors
    @@floor = strategy.initial_floor
    @@time_step = 0
    @@strategy = strategy
    @@direction = 'up'
    @@passengers = passengers
  end

  def incrementWait
    @waiting.each do |i|
      @@passengers.each do |j|
        j.incrementWait if i.id == j.id
      end
    end
  end

  def averageWait
    totalWait = 0
    for i in @@passengers do
      totalWait += i.waitTime.to_i
    end
    return totalWait/(@@passengers.length()-1)
  end

  def incrementTravel
    @boarded.each do |i|
      @@passengers.each do |j|
        j.incrementTravel if i.id == j.id
      end
    end
  end

  def averageTravel
    totalTravel = 0
    for i in @@passengers do
      totalTravel += i.travelTime.to_i
    end
    return totalTravel/(@@passengers.length()-1)

  end

  def run
    @passIndex = 0
    @waiting = []
    @boarded = []
    @ffpeople = 0

    while(@@time_step < @@passengers[@@passengers.length - 1].time.to_i or @boarded.length != 0 or @waiting.length != 0)
      @@time_step += 1
      puts("Time #{@@time_step}: Floor #{@@floor}")

      @passIndex, @waiting = @@strategy.person_calls(@@time_step, @passIndex, @@passengers, @waiting)

      @boarded, @ffpeople = @@strategy.person_gets_on(@waiting, @@floor, @boarded, @ffpeople)

      @ffpeople = @@strategy.person_gets_off(@@floor, @boarded, @ffpeople)

      if(@@strategy.class.to_s == "Strategy1")
        @@floor, @@direction = @@strategy.next_floor(@@floor, @@top_floor, @@direction)
      else
        @@floor, @@direction = @@strategy.next_floor(@@floor, @waiting, @boarded)
      end

      incrementWait
      incrementTravel
    end

    puts("\nNo. of Floors: " + @@top_floor.to_s)
    puts "Average Wait is " + averageWait.to_s + "\nAverage Travel Time is " + averageTravel.to_s
    puts "Time Step Amount: " + @@time_step.to_s
    temp = @ffpeople.to_i
    temp2 = @@passengers.length
    temp3 = temp / temp2.to_f
    temp4 = (@@passengers.length/@@time_step.to_f).round(2)
    puts "Percentage of People That Boards or Leaves 1st Floor: " + (temp3 * 100).round(2).to_s + "%"
    puts("Average Arrival Rate: " + temp4.to_s + " per time step")

  end
end
