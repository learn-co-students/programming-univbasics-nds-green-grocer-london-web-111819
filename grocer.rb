require 'pry'

def find_item_by_name_in_collection(item, cart)
  # Implement me first!
  #
  # Consult README for inputs and outputs

  result = nil

  cart.each do |groceries|
    groceries.each do |key, value|
      if key == :item

        if value == item
          result = groceries
          #binding.pry
        end

      end
    end
  end

  return result

end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.

  final_cart = []

  cart.each do |groceries|
    groceries.each do |key, value|
      if key == :item

        scan_item_in_cart = find_item_by_name_in_collection(groceries[:item], final_cart)

        if scan_item_in_cart == nil

          scan_item_in_cart = {:item => groceries[:item],
                       :price => groceries[:price],
                       :clearance => groceries[:clearance],
                       :count => 1}
                       
              final_cart.push(scan_item_in_cart)
        else
            scan_item_in_cart[:count] += 1
        end

      end
    end
  end

  return final_cart

end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

 # given the cart and coupon arrays, the cart should be updated so that the item
 # that has a coupon applied will be registed as new item :item => "ITEM W/ COUPON"
 # the count on the original item will also be reduced based on the num of the coupon item

 final_cart = cart
 coupon_item = {}

 coupons.each do |coupon|
    coupon.each do |coupon_key, coupon_value|
      if coupon_key == :item

        scan_cart_for_item = find_item_by_name_in_collection(coupon_value,cart)
        coupon_item = find_item_by_name_in_collection("#{coupon_value} W/COUPON", cart)

        if scan_cart_for_item && scan_cart_for_item[:count] >= coupon[:num]

                 if coupon_item == nil

                   coupon_item = {:item => "#{coupon_value} W/COUPON",
                                  :price => coupon[:cost] /coupon[:num],
                                  :clearance => scan_cart_for_item[:clearance],
                                  :count => coupon[:num]}

                    final_cart.push(coupon_item)

                    scan_cart_for_item[:count] -= coupon[:num]

                 else

                   coupon_item[:count] += coupon[:num]
                   scan_cart_for_item[:count] -= coupon[:num]

                   #binding.pry

                 end

               end

          end
      end
  end


return final_cart

end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

  final_cart = cart

  final_cart.each do |groceries|
    groceries.each do |key, value|
      if key == :item

        if groceries[:clearance]

          groceries[:price] -= groceries[:price] * 0.2
          groceries[:price].round(2)

        end

      end
    end
  end

return final_cart

end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers

  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)

  cart_total = 0

  final_cart.each do |groceries|
    groceries.each do |key,value|
      if key == :item

          cart_total += groceries[:price] * groceries[:count]

      end
    end
  end

  if cart_total > 100
    cart_total = cart_total - (cart_total * 0.1)
    cart_total = cart_total.round(2)
  end

 return cart_total

end
