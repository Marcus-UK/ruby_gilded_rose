require_relative 'item.rb'

class GildedRose #Keep track of inventry item quality

  attr_reader :items
  MIN_QUALITY = 0
  MAX_QUALITY = 50
  MIN_SELL_IN = 0

  def initialize(items)#Class is presumably initialized with a list of items (inventry)
    @items = items
  end

  def update_quality #Method to run at the end of each day to update quality
    @items.each do |item| #Breaks item list in to individual components.

      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert" #For anything other than Brie or Backstage Pass, do the following.
        if item.quality > 0 # If item quality is greater than 0, do the following.
          if item.name != "Sulfuras, Hand of Ragnaros" #If the item is not Sulfuras, do the following.
            item.quality = item.quality - 1 #Decrease item quality by 1.
          end
        end
      else
        if item.quality < 50 #This block relates purely to Brie and backstage passes.
          item.quality = item.quality + 1 #quality is increased by 1 per day.
          if item.name == "Backstage passes to a TAFKAL80ETC concert" #If item is a backstage pass.
            if item.sell_in < 11 # and the sell_in is 10 or below...
              if item.quality < 50 # And quality is below 50..
                item.quality = item.quality + 1 #Increase quality by 1 when method is run.
              end
            end
            if item.sell_in < 6 #if backstage pass has less than 6 days to sell...
              if item.quality < 50 # And is less than 50 quality.
                item.quality = item.quality + 1 #Increase quality by 1.
              end
            end
          end
        end
      end
      if item.name != "Sulfuras, Hand of Ragnaros" #If item name is anything other than Sulfuras...
        item.sell_in = item.sell_in - 1 #decrease the sell in date by 1.
      end

      if item.sell_in < 0 #If the sell in date is lower than 0
        if item.name != "Aged Brie" #If item is not Brie..
          if item.name != "Backstage passes to a TAFKAL80ETC concert" #If item name is not backstage pass.
            if item.quality > 0 #If quality is above 0
              if item.name != "Sulfuras, Hand of Ragnaros" #If name is not Sulfuras.
                item.quality = item.quality - 1 #Decrease the item quality by 1.
              end
            end
          else
            item.quality = item.quality - item.quality #Sets item quality to 0 for backstage pass when sell_in date has passed.
          end
        else #This relates to aged brie, iem quality an increase as far as 50
          if item.quality < 50 #
            item.quality = item.quality + 1
          end
        end
      end

    end
  end
end
