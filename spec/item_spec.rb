require './lib/item.rb'

describe Item do
  subject(:item) { described_class.new('golden turnip', 10, 25) }

  it 'is instantiated with a name' do
    expect(item.name).to eq 'golden turnip'
  end

  it 'is instantiated with a sell_in value' do
    expect(item.sell_in).to eq 10
  end

  it 'is instantiated with a quality value' do
    expect(item.quality).to eq 25
  end

end
