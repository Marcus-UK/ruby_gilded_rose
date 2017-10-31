require './lib/gilded_rose.rb'

describe GildedRose do
  subject(:rose) {described_class.new(items)}
  let(:items) { [Item.new('golden turnip', 10, 5),
                 Item.new('Aged Brie', 2, 0),
                 Item.new('Sulfuras, Hand of Ragnaros', 0, 80),
                 Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 40),
                 Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 40),
                 Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 40),
                 Item.new('boring normal item', 0, 5)]}

  it 'is instantiated with an items list' do
    expect(rose.items).to eq items
  end

  describe "#update_quality" do
    it "does not change the name" do
      rose.update_quality
      expect(rose.items[0].name).to eq "golden turnip"
    end

    it 'reduces the sell_in value by 1 for all items' do
      rose.update_quality
      expect(rose.items[0].sell_in).to eq 9
    end

    it 'reduces the quality of normal items by 1 if there sell_in value is > 0' do
      rose.update_quality
      expect(rose.items[0].quality).to eq 4
    end

    it 'reduces the quality of normal items by 2 if sell_in value < 0' do
      rose.update_quality
      expect(rose.items[6].quality).to eq 3
    end

    it 'doesn\'t reduce the quality of an item below 0' do
      6.times { rose.update_quality }
      expect(rose.items[0].quality).to eq 0
    end

    it 'increase the quality of Aged Brie by 1 if its quality value is below 50' do
      rose.update_quality
      expect(rose.items[1].quality).to eq 1
    end

    it 'no longer increase the quality of brie when it has reached 50' do
      51.times { rose.update_quality }
      expect(rose.items[1].quality).to eq 50
    end

    it 'does not change the quality of Sulfuras' do
      rose.update_quality
      expect(rose.items[2].quality).to eq 80
    end

    it 'increase the quality of backstage passes by 1 when sell_in > 10 ' do
      rose.update_quality
      expect(rose.items[3].quality).to eq 41
    end

    it 'increase the quality of backstage passes by 2 when sell_in < 10 & > 5' do
      rose.update_quality
      expect(rose.items[4].quality).to eq 42
    end

    it 'increase the quality of backstage passes by 3 when sell_in < 5' do
      rose.update_quality
      expect(rose.items[5].quality).to eq 43
    end

    it 'reduces the quality of backstage passes to 0 when sell_in < 0' do
      6.times { rose.update_quality }
      expect(rose.items[5].quality).to eq 0
    end
  end
end
