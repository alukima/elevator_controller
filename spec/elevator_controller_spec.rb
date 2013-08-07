require 'spec_helper'

describe ElevatorController do

	directions = [:up, :down]
	floors = Random.rand(1..40)
	elevators = Random.rand(1..5)
	subject { ElevatorController.new(floors, elevators)}

	describe "#intialize" do
		it 'has the correct number of floors' do
			expect(subject.floors).to eq(floors)
		end

		it 'has the correct amount of elevators' do
			expect(subject.elevators.length).to eq(elevators)
		end

		it 'has an array of elevator objects' do
			expect(subject.elevators.first).to be_instance_of(Elevator)
		end

		it 'has zero requests' do
			expect(subject.requests.length).to eq(0)
		end
	end

	describe '#new_request' do
		it 'when it recieves a new request it create a request object' do
			subject.new_request(17, :down)
			expect(subject.requests.first).to be_instance_of(Request)
		end

		it 'puts it into requests' do
			4.times {subject.new_request(Random.rand(5), directions.sample)}
			expect(subject.requests.length).to eq(4)
		end
	end

	describe '#idle' do
		context 'if elevators are not in use' do
			it "returns an elevator with a status of :not_in_use" do
				(elevators -1).times {subject.new_request(Random.rand(5), directions.sample)}
				expect(subject.idle.status).to eq(:not_in_use)
			end
		end

		context 'when all elevators are in use' do
			it 'returns nil' do
				subject.elevators.each { |e| e.status = :up}
				expect(subject.idle).to eq(nil)
			end

			it 'does not return an Elevator Object' do
				subject.elevators.each { |e| e.status = :up}
				expect(subject.idle).to_not be_instance_of(Elevator)
			end
		end
	end

	describe '#assign_requests' do
		context 'when there is an elevator with status not in use' do
			it 'assigns the request to that elevator' do
				700.times {subject.new_request(Random.rand(80), :up)}
				subject.assign_requests
				expect(subject.requests.length).to eq(0)
			end
		end

		context 'when all elevators are in use' do
			it 'looks for an elevator going in the same direction' do

			end
		end


		context 'when each elevators queue is < 2' do
			it 'assigns the request to the elevator in range with the shortest queue' do
			end
		end
	end

end
