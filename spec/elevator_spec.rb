require 'spec_helper'


describe Elevator do
  current_floor = Random.rand(40)
  subject {Elevator.new(current_floor)}
  
  describe "when intialized" do
    it 'has a current_floor' do
      subject.current_floor.should == current_floor
    end

    it 'has a stats of not in use' do
      subject.status == :not_in_use
    end
  end

  describe '#button_press' do
    context 'if status is :not_in_use'  do
      it 'completes queue' do
        subject {Elevator.new(current_floor)}
        subject.button_press(13)
        expect(subject.current_floor).to eq(13)
      end

      context 'if status is :up or :down' do
        it 'sets the correct status' do
          subject.current_floor == 1
          subject.button_press(20)
          subject.status == :up
        end

        it 'adds the request to the end of the queue' do
          subject.current_floor == 30
          subject.button_press(1)
          subject.status == :down
        end
      end
    end

    context 'with multiple requests' do
      it "ends at the last floor in queue" do
        subject.button_press(13)
        subject.button_press(7)
        subject.button_press(14)
        expect(subject.current_floor).to eq(14)
      end
    end
  end

  describe '#complete_queue' do
    it 'empties the queue' do
      4.times {subject.queue.push(Random.rand(40))}
      subject.instance_eval{complete_queue}
      expect(subject.queue.length).to eq(0)
    end

    it 'sets the status to :not_in_use when complete' do
      4.times {subject.queue.push(Random.rand(40))}
      subject.instance_eval{complete_queue}
      expect(subject.status).to eq(:not_in_use)
    end

    it 'sets the correct status' do
      subject {Elevator.new(1)}
      subject.queue.push(14)
      subject.instance_eval{complete_queue}
      subject.status == :up
    end
  end

end







