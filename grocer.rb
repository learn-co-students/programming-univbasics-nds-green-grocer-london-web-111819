require 'pp'
require 'pry'

def find_item_by_name_in_collection(name, collection)
  counter = 0
  while counter < collection.length do 
    if collection[counter][:item] == name
      return collection[counter]
    end
    counter += 1
  end
end

def consolidate_cart(cart)
 new_cart = []
 cart.each do |item|
   new_cart_item = find_item_by_name_in_collection(item[:item], new_cart)
   if new_cart_item
     new_cart_item[:count] += 1
   else
     new_cart_item = {
       :item => item[:item],
       :price => item[:price],
       :clearance => item[:clearance],
       :count => 1
     }
     new_cart.push(new_cart_item)
   end
 end
 new_cart
end

def apply_coupons(cart, coupons)
  cart.each do |item|
    coupons.each do |coupon|
      if coupon[:item] == item[:item] && item[:count] >= coupon[:num]
        coupon_hash = {
          :item => coupon[:item] + ' W/COUPON',
          :price => coupon[:cost] / coupon[:num],
          :clearance => item[:clearance],
          :count => coupon[:num]
        }
        item[:count] = item[:count] - coupon[:num]
        cart.push(coupon_hash)
    end
    end
  end
  cart
end

def apply_clearance(cart)
  consolidate_cart(cart)
  cart.each do |item|
    if item[:clearance] == true
      item[:price] = item[:price] - (item[:price] * 0.2)
    end
  end
end

def checkout(cart, coupons)
  final_cart = consolidate_cart(cart)
  apply_coupons(final_cart, coupons)
  apply_clearance(final_cart)
  items_price = 0
  total = 0
  
  final_cart.each do |item|
  if item[:clearance] == false && coupons.length == 0
    items_price = item[:count] * item[:price]
    total += items_price
  else 
    items_price = item[:count] * item[:price]
    total += items_price
    # binding.pry
  end
  end
  if total >= 100 
    total = total - (total * 0.1)
  end
  total
end
