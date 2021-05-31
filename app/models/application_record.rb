class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def seller
    User.find(self.seller_id)
  end
end
