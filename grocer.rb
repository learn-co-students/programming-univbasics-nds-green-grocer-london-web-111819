require 'pp'

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  i = 0
  while i < collection.length do 
    if collection[i][:item] == name
      return collection[i]
    end
    i += 1
  end
  nil
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.i=
  final_cart=[]
  i = 0
  while i < cart.length do
     item_name = cart[i][:item]
     item_price = cart[i][:price]
     item_clearance = cart[i][:clearance]

    if final_cart.length == 0
      final_cart = [{:item => item_name, :price => item_price, :clearance => item_clearance, :count => 1}]
    elsif find_item_by_name_in_collection(item_name, final_cart)
      ii = 0
      while ii < final_cart.length do
          if final_cart[ii][:item] == item_name
            final_cart[ii][:count] += 1
          end
          ii += 1
      end
    else
      final_cart << {:item => item_name, :price => item_price, :clearance => item_clearance, :count => 1}
    end
    i += 1
  end
  final_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i=0
  used_coupons =[]
  while i < coupons.length do
    n = 0
    item_name = coupons[i][:item]
    if used_coupons.include?(item_name) 
      i += 1
      next
    end
    used_coupons << item_name
      while n < cart.length do
       if cart[n][:item] == item_name
        cart[n][:count] -= coupons[i][:num]
        cart << {:item => "#{cart[n][:item]} W/COUPON", :price => coupons[i][:cost]/coupons[i][:num],:clearance => cart[n][:clearance], :count => coupons[i][:num]}
       end
     n += 1
    end
     i += 1
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0 
  while i < cart.length do 
    if cart[i][:clearance] == true 
      new_price = cart[i][:price]*0.8
      cart[i][:price] = new_price.round(2)
    end
    i += 1
  end
    cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
    # * apply_coupons
  # * apply_clearance
  cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  total = 0 
  i = 0 
  while i < cart.length do 
    price_per_type = cart[i][:price]*cart[i][:count]
    total += price_per_type
    i += 1 
  end
  if total > 100
    with_discount = total * 0.9
    total = with_discount.round(2)
  end
  total
end
