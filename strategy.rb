require './person'
require './elevator'

# Strategies are algorithms to which the elevator will use to determine its directions.
# Two strategies are implemented in this project.
class Strategy1
  def initial_floor
    return 1
  end

  def next_floor(floor, top_floor, direction)
    if (direction == 'up' and floor < top_floor)
      return floor += 1, direction = 'up'
    elsif (direction == 'up' and floor == top_floor)
      return floor -= 1, direction = 'down'
    elsif (direction == 'down' and floor > 1)
      return floor -= 1, direction = 'down'
    elsif (direction == 'down' and floor == 1)
      return floor += 1, direction = 'up'
    end
  end

  def person_calls(time, passIndex, passengers, waiting)

    (passIndex..passengers.length()-1).each do |i|
      if passengers[i].time.to_i == time
        puts(passengers[i].id + " calls elevator from " + passengers[i].origin)
        waiting << passengers[i]
        passIndex += 1
      end
    end
    return passIndex, waiting
  end

  def person_gets_on(waiting, floor, boarded, ffpeople)
    wait = []
    wait.concat waiting
    wait.each do |i|
      if i.origin.to_i == floor
        if(floor.to_i == 1)
          ffpeople += 1
        end
        puts "Passenger " + i.id.to_s + " boards from floor " + floor.to_s
        boarded << i
        waiting.delete(i)
      end
    end
    return boarded, ffpeople
  end

  def person_gets_off(floor, boarded, ffpeople)
    board = []
    board.concat boarded
    board.each do |i|
      if i.destination.to_i == floor
        if(floor.to_i == 1)
          ffpeople += 1
        end
        puts "Passenger " + i.id.to_s + " debarks to floor " + floor.to_s
        boarded.delete(i)
      end
    end
    return ffpeople
  end
end
