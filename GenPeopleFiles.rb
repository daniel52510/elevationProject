
# GenPeopleFiles.rb
# You can use to generate your own random data files of my elevator format.
# The following generates a single file named 'temp1.in' where there
# are 10 floors, elevator call events occur on average 2 per minute,
# and data extends out for 20 minutes. There is a 90% chance that one of the
# two floors that a passenger moves between is the first floor (floor 1).
#
#  GenPeopleFiles.gen_input_file('temp1.in', 10, 2, 20, 0.9)
#
# And this generates four files named 'dd000.in' through 'dd003.in',
# representing 10 floors, an average event rate of 3 per minute,
# over 20 minutes:
#
#  GenPeopleFiles.gen_input_files('dd', 4, 10, 3, 20, 0.9)
module GenPeopleFiles
  class << self
    # rate is the average number of events (elevator calls)
    # per time unit
    # generate one input file
    def gen_input_file(filename, nbr_floors, rate, max_time, p)
      File.open(filename, 'w') do |f|
        time = 1
        indx = 99
        f.puts(nbr_floors)
        loop do
          time += sleep_for(rate)
          break if time >= max_time+1
          indx += 1
          if rand > p then
            org = rand_in_range(2, nbr_floors+1)
            dest = rand_in_range(2, nbr_floors)
            dest += 1 if dest >= org
          else
            if rand < 0.5 then
              org = 1
              dest = rand_in_range(2, nbr_floors+1)
            else
              org = rand_in_range(2, nbr_floors+1)
              dest = 1
            end
          end
          res = [indx, time.to_i, org, dest]
          res = res.map(&:to_s).join(' ')
          f.puts(res)
        end
      end
    end
    # generate a sequence of input files
    def gen_input_files(fileprefix, nbr_files, nbr_floors, rate, max_time, p)
      nbr_files.times do |n|
        filename = fileprefix + ("%.3d" % n) + '.in'
        gen_input_file(filename, nbr_floors, rate, max_time, p)
      end
    end
    # Poisson process
    def sleep_for(rate)
      -Math.log(1.0 - Random.rand) / rate
    end
    def rand_in_range(a, b)
      rand(b-a) + a
    end
  end
end
def main
  GenPeopleFiles.gen_input_files('myInput', 1, 8, 0.5, 120, 0.9)
end
main()