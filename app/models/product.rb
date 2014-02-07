class Product
  
  attr_accessor :price
  attr_accessor :description
  
  # Create wine product based on wine id
  
  def self.for_id(id)
    case id
    when 1
      return Product.red_wine_only
    when 2
      return Product.white_wine_only
    when 3
      return Product.mixed_wine
    else
      return Product.mixed_wine
    end
  end
  
  # Factories for the different wine products
  
  def self.red_wine_only # Red wine only
    product = Product.base_product
    product.description = "Red wine product"
    product
  end
  
  def self.white_wine_only # White wine only
    product = Product.base_product
    product.description = "White wine product"
    product
  end
  
  def self.mixed_wine # Both red and white wine in a single package
    product = Product.base_product
    product.description = "Mixed wine product"
    product
  end
  
  # Base factory
  
  def self.base_product
    product = Product.new
    product.price = 6999 + product.shipping
    return product
  end
  
  # Shipping helper
  
  def shipping
    return 0
  end
  
  # Charge card
  def charge(token)
    Stripe.api_key = "sk_test_ZgaxorKc4yvnksAe9VLvZPIP"
    Stripe::Charge.create(amount: self.price, currency: "usd", card: token, description: self.description)
  end
  
end