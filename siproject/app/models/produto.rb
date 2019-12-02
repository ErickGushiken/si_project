class Produto < ApplicationRecord
    has_many :line_items

    before_destroy :ensure_not_referenced_by_any_line_item

    mount_uploader :image, ImageUploader
    serialize :image, JSON
    belongs_to :user, optional: true

    validates :nome, :descricao, :valor, :categoria, :image, presence: true
    validates :descricao, length: { maximum: 1000, too_long: "%{count} characters is the maximum aloud. "}
    validates :nome, length: { maximum: 140, too_long: "%{count} characters is the maximum aloud. "}
    validates :valor, length: { maximum: 7 }, numericality: true

    CATEGORIA = %w{ Imagem Cards Trabalho }

    private

    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
        unless line_items.empty?
            errors.add(:base, 'Line Items present')
            throw :abort
        end
    end
end
