RSpec.describe Bounds do
  let(:min) { Position.at(0, 0) }
  let(:max) { min.step(2, 2) }

  subject { described_class.new(min, max) }

  describe '#out?' do
    it 'is out when the position is outside the min and max' do
      is_expected.to be_out(min.left)
      is_expected.to be_out(min.down)
      is_expected.to be_out(max.right)
      is_expected.to be_out(max.up)
    end

    it 'is not out when on the boundary' do
      is_expected.not_to be_out(min)
      is_expected.not_to be_out(max)
    end

    it 'is not out when within the boundary' do
      is_expected.not_to be_out(min.right.up)
    end
  end
  
  describe '#contains?' do
    it 'contains the position when on the boundary' do
      expect(subject.contains?(min)).to be true
      expect(subject.contains?(max)).to be true
    end

    it 'contains the position when within the boundary' do
      expect(subject.contains?(min.right.up)).to be true
    end

    it 'does not contain the position when outside of the boundary' do
      expect(subject.contains?(min.left)).to be false
      expect(subject.contains?(min.down)).to be false
      expect(subject.contains?(max.right)).to be false
      expect(subject.contains?(max.up)).to be false
    end
  end

  describe '#each' do
    it 'yields each position between the min and max' do
      positions = [
        min, min.right, min.right(2),
        min.up, min.step(1, 1), min.step(2, 1),
        min.up(2), min.step(1, 2), max
      ]
      expect { |b| subject.each(&b) }.to yield_successive_args(*positions)
    end
  end

  describe '#move' do
    it 'shifts the bounds in the provided direction' do
      dir = 1000
      moved_bounds = subject.move(dir, dir)
      expect(moved_bounds).to be_out(min)
      expect(moved_bounds).to be_out(max)
      expect(moved_bounds.contains?(min.step(dir, dir)))
      expect(moved_bounds.contains?(max.step(dir, dir)))
    end

  end

  describe '#position' do
    it 'yields the minimum position when no arguments are provided' do
      expect { |b| subject.position(&b) }.to yield_with_args(min)
    end

    it 'yields a position relative to the minimum when `from` is not provided' do
      step = 1
      expect { |b| subject.position(step, step, &b) }.to yield_with_args(min.step(step, step))
    end

    it 'does not yield when the position is out of bounds' do
      expect { |b| subject.position(100, 100, &b) }.not_to yield_control
    end

    it 'yields a position relative to the `from` position' do
      expect { |b| subject.position(from: max, &b) }.to yield_with_args(max)
      expect { |b| subject.position(-2, -2, from: max, &b) }.to yield_with_args(min)
    end
  end
end
