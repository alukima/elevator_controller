require_relative 'elevator.rb'
require_relative 'request.rb'
require 'thread'


class ElevatorController

	attr_reader :floors, :elevators, :requests

	def initialize(floors, elevator_quantity)
		@floors = floors
		@elevators = []
		@requests = []
		create_elevators(elevator_quantity)
	end

	def create_elevators(elevator_quantity)
		elevator_quantity.times do 
			@elevators << Elevator.new(1)
		end
	end

	def new_request(floor, direction)
		@requests.push(Request.new(floor, direction))
	end

	def assign_requests
		until @requests.empty?
			@oldest_request = @requests.shift
			@elevator = find_elevator
			@elevator.queue.push(@oldest_request.floor)
		end
		@elevators.each {|e| e.complete_queue}
	end	

	def find_elevator 
		idle || shortest_queue
	end

	def idle
		@elevators.detect { |e| e.status == :not_in_use}
	end

	def shortest_queue
		p @elevators.detect {|e| e.status == @oldest_request.direction} 
	end

	def in_range(floor)
		puts 'hello'
		if @oldest_request.direction == :up
			@oldest_request.floor - floor > 1
		else
			floor - @oldest_request.floor > 1
		end
	end

end
