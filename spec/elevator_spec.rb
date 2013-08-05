require 'spec_helper'


describe Elevator do
  floor = Random.rand(40)
  subject { Elevator.new(10, floor)}

  context "when intialized" do
    it 'has a current_floor' do
      subject.current_floor.should == floor
    end

    it 'has a stats of not in use' do
      subject.status == :not_in_use
    end
  end

  it "knows how many floors it serves" do
    expect(subject.floors_served).to  eq(10)
  end

  describe "#button_press" do
    it "on button press it queues floors" do
      subject.button_press(13)
      subject.button_press(15)
      expect(subject.queue).to eq([13, 15])
    end
  end
    describe '#moving' do
      context 'with one floor request' do
        it "moves to the next floor in queue" do
          subject.button_press(13)
          subject.get_destination
          expect(subject.current_floor).to eq(13)
        end
      end

      context 'with multiple requests' do
        it "ends at the last floor in queue" do
          subject.button_press(13)
          subject.button_press(7)
          subject.button_press(14)
          subject.get_destination
          expect(subject.current_floor).to eq(13)
        end
      end
    end
  end
