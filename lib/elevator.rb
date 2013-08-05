class Elevator
  attr_reader :status, :floors_served, :current_floor, :queue

  def initialize(floors, current_floor)
    @floors_served = floors
    @current_floor = current_floor 
    @status = :not_in_use
    @queue = []

  end

  def button_press(floor)
    @queue.push(floor)
    #thid is where a method to set placement would go
  end 

  def get_destination
    @destination_floor = @queue.first 
    if @destination_floor > @current_floor 
      up
    else
      down
    end
  end 


  def up
    @status = :going_up 
    moving(1)
  end

  def down 
    @status = :going_down
    moving(-1)
  end

  def moving(increment)
    until @current_floor == @destination_floor
      @current_floor = @current_floor + increment
      sleep(1)
      puts "On the #{@current_floor} floor.."
      boarding?
    end
  end

  def boarding?
    if @current_floor == @destination_floor
      puts "boarding..."
      sleep(5) #wait for people to get on
      @queue.pop
    end
  end

end

