RSpec.describe GridPosition do
  it 'cannot be constructed outside of factory methods' do
    expect { described_class.new(1, 1) }.to raise_error(NoMethodError)
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
