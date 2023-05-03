require './elevator'
require './strategy'
require './strategy2'

class Person
  def initialize(id,time,origin,dest)
    @id = id
    @time = time
    @origin = origin
    @destination = dest
    @waitTime = 0
    @travelTime = 0
  end

  def id
    return @id
  end

  def time
    return @time
  end

  def origin
    return @origin
  end

  def destination
    return @destination
  end

  def waitTime
    return @waitTime
  end

  def incrementWait
    @waitTime += 1
  end

  def travelTime
    return @travelTime
  end

  def incrementTravel
    @travelTime += 1
  end
end
