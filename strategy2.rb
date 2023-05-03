require './person'
require './elevator'
class Strategy2
  def initial_floor
    return 5
  end

  def next_floor(floor, waiting, boarded)
    if(boarded.length > 0)
      if(floor > boarded[0].destination.to_i)
        floor -= 1
      elsif(floor < boarded[0].destination.to_i)
        floor += 1
      end
    elsif(waiting.length > 0)
      if(floor > waiting[0].origin.to_i)
        floor -= 1
      elsif(floor < waiting[0].origin.to_i)
        floor += 1
      end
    else
      puts("Elevator Stopped at Floor " + floor.to_s)
    end
    return floor
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
        if(floor == 1)
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
        if(floor == 1)
          ffpeople += 1
        end
        puts "Passenger " + i.id.to_s + " debarks to floor " + floor.to_s
        boarded.delete(i)
      end
    end
    return ffpeople
  end
end
