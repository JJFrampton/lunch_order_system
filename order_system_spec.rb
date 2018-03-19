#!/usr/bin/env ruby

require 'minitest/autorun'
require 'minitest/spec'
require './models.rb'
require './controller.rb'

class TestSuite < MiniTest::Unit::TestCase
	describe Order do
    	before do
    	   @order = Order.new(50,5,7)

    	   @restaurants = Restaurants.new()
    	   restaurant_a = Restaurant.new('restaurant a', 5, 5, 40, 4, 0)
    	   restaurant_b = Restaurant.new('restaurant b', 3, 5, 100, 20, 20)
    	   @restaurants.list << restaurant_b
    	   @restaurants.list << restaurant_a
    	   start_order(@order, @restaurants, false)

    	end
		describe "breakdown" do
			it "must have zero for all types" do
				@order.breakdown.each do | key, value |
					assert(value <= 0)
				end
			end
		end
		describe "order per restaurant" do
			it "will be less than capacity" do
				@restaurants.list.each do |restaurant|
					restaurant.order_placed.each do |type, amount|
						assert(amount <= restaurant.send(type)) unless type == 'regular'
					end
				end
			end
		end
		describe "order over capacity" do
			it "will be throw error" do
    	   		@order = Order.new(500,5,7)
    	   		proc {start_order(@order, @restaurants, false)}.must_raise ArgumentError
			end
		end

		describe "when order arguments are too few" do
			it "will raise exception" do
    	   		proc {Order.new(5,5,7)}.must_raise ArgumentError
			end
		end
		describe "when order total too small" do
			it "will raise exception" do
    	   		proc {Order.new(5,5,7)}.must_raise ArgumentError
			end
		end
	end
end
