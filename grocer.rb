def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
#* Arguments:
#  * `String`: name of the item to find
#  * `Array`: a collection of items to search through
#* Returns:
#  * `nil` if no match is found
#  * the matching `Hash` if a match is found between the desired name and a given 
#    `Hash`'s :item key
  index = 0 ; output = nil
  while index < collection.length do
    if (collection[index][:item] == name) 
      output=collection[index]
    end
    index= index + 1 
  end
  return output
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  index = 0 ; new_cart = []
  while index < cart.length do
    get_the_currently_existing = find_item_by_name_in_collection(cart[index][:item],new_cart)
    if (get_the_currently_existing == nil)
      get_the_currently_existing = cart[index]
      get_the_currently_existing[:count]=1 
    else
      get_the_currently_existing[:count] = get_the_currently_existing[:count] + 1
      new_cart.delete_if { |h| h[:item] == cart[index][:item]}
    end
    new_cart << get_the_currently_existing
    index = index +1 
  end
  new_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index2 = 0
  temp = cart.length
  
  while index2 < temp do
    construct_entries_discounted = {} #changed07Nov19 from cart[index2]
    get_item_coupon_details = find_item_by_name_in_collection(cart[index2][:item],coupons)
    if get_item_coupon_details != nil
      how_many_discounted_groups = cart[index2][:count].div(get_item_coupon_details[:num])
      
      cart[index2][:item] = cart[index2][:item]
      cart[index2][:count] = cart[index2][:count]-(how_many_discounted_groups*get_item_coupon_details[:num])
      cart[index2][:price] = cart[index2][:price]
      cart[index2][:clearance] = cart[index2][:clearance]
      
      construct_entries_discounted[:item] = cart[index2][:item] + " W/COUPON"
      construct_entries_discounted[:price] = get_item_coupon_details[:cost] / get_item_coupon_details[:num]
      construct_entries_discounted[:count] =how_many_discounted_groups*get_item_coupon_details[:num]
      construct_entries_discounted[:clearance] = cart[index2][:clearance]
      cart << construct_entries_discounted
    end
    index2 = index2 + 1 
  end
  #p cart
  return cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index3 = 0
  while index3 < cart.length do
    if cart[index3][:clearance]
      cart[index3][:price] = (cart[index3][:price]*0.8).to_f.round(2)
    end
    index3 = index3 + 1 
  end
  p cart
  return cart
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
  good_list = apply_clearance(apply_coupons(consolidate_cart(cart),coupons))
  index4 = 0 ; total = 0
  while index4 < good_list.length do
    total = total + (good_list[index4][:price] * good_list[index4][:count])
    index4 = index4 + 1 
  end
  if total > 100
    total = total*0.9
  end
  return total
end

sample_array = [
  {:item => "AVOCADO", :price => 10.00, :clearance => true},
  {:item => "AVOCADO", :price => 10.00, :clearance => true},
  {:item => "AVOCADO", :price => 10.00, :clearance => true},
  {:item => "AVOCADO", :price => 10.00, :clearance => true},
  {:item => "KALE", :price => 10.00, :clearance => false},
  {:item => "KALE", :price => 10.00, :clearance => false},
  {:item => "AVOCADO", :price => 10.00, :clearance => true},
  {:item => "PEAR", :price => 10.00, :clearance => true}
  ]

sample_coupon_array = [
  {:item => "AVOCADO", :num=> 3, :cost => 27.00},
  {:item => "KALE", :num=> 3, :cost => 24.00}
  ]
 
#p find_item_by_name_in_collection("PEAR",sample_array)
consolidated = consolidate_cart(sample_array)
apply_clearance(apply_coupons(consolidated,sample_coupon_array))