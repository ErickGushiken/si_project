class LineItem < ApplicationRecord
  belongs_to :produto
  belongs_to :cart
end
