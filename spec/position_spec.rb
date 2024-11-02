RSpec.describe Position do
  describe 'Class Methods' do
    it 'cannot be constructed outside of factory methods' do
      expect { described_class.new(1, 1) }.to raise_error(NoMethodError)
    end

    describe '.at' do
      let(:center_offset) { grid_scale / 2 }
      let(:x) { grid_scale + 1 }
      let(:y) { grid_scale + 1 }

      subject { described_class.at(x, y) }

      it 'snaps the provided co-ordinates to the center of a grid position' do
        is_expected.to be_at(grid_scale + center_offset, grid_scale + center_offset)
      end
    end

    describe '.scale' do
      it 'scales a number to match the grid' do
        n = 13
        expect(described_class.scale(n)).to eq grid_scale * n
      end
    end

    describe '.scale=' do
      it 'allows the scale of the grid to be configured' do
        custom_scale = 50
        expect { described_class.scale = custom_scale }
          .to change { described_class.scale(1) }
          .to custom_scale
      end
    end
  end

  describe 'Instance Methods' do
    let(:x) { grid_scale }
    let(:y) { grid_scale }
    let(:position) { described_class.at(x, y) }

    describe '#step' do
      it 'does not move when called without arguments' do
        expect(position.step).to eq position
      end

      it 'does not move when direction is zero' do
        expect(position.step(0, 0)).to eq position
      end
      

      it 'can move 1 tile to the right' do
        expect(position.step(1, 0)).to eq described_class.at(grid_scale * 2, grid_scale)
      end

      it 'can move 1 tile to the left' do
        expect(position.step(-1, 0)).to eq described_class.at(0, grid_scale)
      end

      it 'can move 1 tile up' do
        expect(position.step(0, 1)).to eq described_class.at(grid_scale, grid_scale * 2)
      end

      it 'can move 1 tile down' do
        expect(position.step(0, -1)).to eq described_class.at(grid_scale, 0)
      end

      it 'can move multiple tiles' do
        distance = 100
        expected_coord = grid_scale * distance.succ
        expect(position.step(distance, distance)).to eq described_class.at(expected_coord, expected_coord)
      end
    end

    describe 'relative comparisons' do
      let(:far_above) { described_class.at(0, 100000) }
      let(:far_below) { described_class.at(0, -100000) }
      let(:far_right) { described_class.at(100000, 0) }
      let(:far_left) { described_class.at(-100000, 0) }

      subject { position }

      it { is_expected.to be_right_of(far_left) }
      it { is_expected.to be_right_of(x: -100000) }
      it { is_expected.not_to be_right_of(far_right) }
      it { is_expected.not_to be_right_of(position) }
      it { is_expected.not_to be_right_of(x: 100000) }

      it { is_expected.to be_left_of(far_right) }
      it { is_expected.to be_left_of(x: 1000000) }
      it { is_expected.not_to be_left_of(far_left) }
      it { is_expected.not_to be_left_of(position) }
      it { is_expected.not_to be_left_of(x: -100000) }

      it { is_expected.to be_above(far_below) }
      it { is_expected.to be_above(y: -10000) }
      it { is_expected.not_to be_above(far_above) }
      it { is_expected.not_to be_above(position) }
      it { is_expected.not_to be_above(y: 10000) }

      it { is_expected.to be_below(far_above) }
      it { is_expected.to be_below(y: 10000) }
      it { is_expected.not_to be_below(far_below) }
      it { is_expected.not_to be_below(position) }
      it { is_expected.not_to be_below(y: -10000) }
    end

    describe '#place' do
      it 'centers the body at the position' do
        body = spy('Fake Body')
        allow(body).to receive(:size).and_return(grid_scale)
        expect(body).to receive(:x=).with(x)
        expect(body).to receive(:y=).with(y)
        position.place(body)
      end
    end
  end
end
