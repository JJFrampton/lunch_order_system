#!/usr/bin/env ruby

require './models.rb'
require './controller.rb'

restaurants = Restaurants.new()
restaurant_a = Restaurant.new('restaurant a', 5, 5, 40, 4, 0)
restaurant_b = Restaurant.new('restaurant b', 3, 5, 100, 20, 20)
restaurants.list << restaurant_b
restaurants.list << restaurant_a


order_request = Order.new(50,5,7)
#order_request = Order.new(33,2,5)
#order_request = Order.new(3,2,5)
#order_request = Order.new(300,2,5)
#order_request = Order.new(50)

start_order(order_request, restaurants, true)
