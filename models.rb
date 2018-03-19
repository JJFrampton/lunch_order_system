#!/usr/bin/env ruby

class Options
    attr_accessor :total, :vegetarian, :gluten_free, :regular
    def initialize(total, vegetarian, gluten_free)
        raise ArgumentError, 'total must be greater than the sum of vegetarian and gluten_free' if total < (vegetarian + gluten_free)
        @total = total
        @vegetarian = vegetarian
        @gluten_free = gluten_free
        @regular = total - (vegetarian + gluten_free)
    end
end

class Order < Options
    attr_accessor :breakdown
    def initialize(total, vegetarian, gluten_free)
		vegetarian = 0 unless vegetarian
		gluten_free = 0 unless gluten_free
        super(total, vegetarian, gluten_free)
        @breakdown = {
            'regular' => @regular,
            'vegetarian' => @vegetarian,
            'gluten_free' => @gluten_free
        }
    end
end

class Restaurant < Options
    attr_accessor :name, :score, :order_placed
    def initialize(name, score, out_of, total, vegetarian, gluten_free)
        @name = name
        @score = score.to_f / out_of.to_f
        super(total, vegetarian, gluten_free)
    end
    def place_order(order)
        @order_placed = {}
        @order_placed['total'] = 0
        order.breakdown.each do |key, value|
            value1 = value.to_i
            value2 = value1 - self.send(key)
            if value2 >= 0
                @order_placed[key] = self.send(key)
                order.breakdown[key] = value2
                @order_placed['total'] += @order_placed[key]
            else
                @order_placed[key] = value1
                @order_placed['total'] += @order_placed[key]
                order.breakdown[key] = 0
            end
        end
    end
    def print_order
        puts ""
        puts "order for #{self.name} :
            regular : #{self.order_placed['regular']}
            vegetarian: #{self.order_placed['vegetarian']}
            gluten_free: #{self.order_placed['gluten_free']}
            total: #{self.order_placed['total']}"
    end
end

class Restaurants
  attr_accessor :list, :totals
  def initialize()
    @list = []
    @totals = {}
  end
  def sort
      @list = @list.sort_by {|restaurant| restaurant.score }.reverse
  end
  def get_totals
      self.list.each do |restaurant|
          @totals['regular'] ? @totals['regular'] += restaurant.regular : @totals['regular'] = 0
          @totals['vegetarian'] ? @totals['vegetarian'] += restaurant.vegetarian : @totals['vegetarian'] = 0
          @totals['gluten_free'] ? @totals['gluten_free'] += restaurant.gluten_free : @totals['gluten_free'] = 0
      end
  end
end
