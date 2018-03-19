#!/usr/bin/env ruby

def start_order(order_request, restaurants, print)
    restaurants.sort
    restaurants.get_totals
    ord = order_request.breakdown
    cap = restaurants.totals
    (ord.keys & cap.keys).each do |key|
        raise ArgumentError, "There is not enough capacity to fulfill the request for #{key}" unless ord[key] < cap[key]
    end
    restaurants.list.each do |restaurant|
        restaurant.place_order(order_request)
        restaurant.print_order unless print == false
    end
end
