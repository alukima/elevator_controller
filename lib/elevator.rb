class Elevator
  attr_reader :current_floor
  attr_accessor :queue, :status

  def initialize(current_floor)
    @current_floor = current_floor 
    @status = :not_in_use
    @queue = []
  end

  #internal button press
  def button_press(floor)
    @queue.push(floor)
    if @status == :not_in_use
      complete_queue
    end
  end 

 def complete_queue
    get_destination
    set_direction
    change_floors
    destination?
    done?
  end

private

  def set_direction
    if @destination_floor > @current_floor 
      @status = :up 
    else
      @status = :down
    end
  end 

  def get_destination
    @destination_floor = @queue.shift 
  end

  def change_floors
    until  @current_floor == @destination_floor
      puts "On floor #{@current_floor}"
      #sleep(1)
      @current_floor = @current_floor + increment
    end
  end

  def increment
    if @status == :up
      1
    else
      -1
    end
  end

  def destination?
    if @current_floor == @destination_floor
      puts "boarding..."
      #sleep(1) #wait for people to get on
    end
  end

  def done?
    if @queue.empty?
      @status = :not_in_use
      @destination_floor == nil
    else
      complete_queue
    end
  end

end

