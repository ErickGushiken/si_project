class Produto < ApplicationRecord
    mount_uploader :image, ImageUploader
    serialize :image, JSON
    belongs_to :user, optional: true

    validates :nome, :descricao, :valor, :categoria, presence: true
    validates :descricao, length: { maximum: 1000, too_long: "%{count} characters is the maximum aloud. "}
    validates :nome, length: { maximum: 140, too_long: "%{count} characters is the maximum aloud. "}
    validates :valor, length: { maximum: 7 }, numericality: true

    CATEGORIA = %w{ Imagem Cards Trabalho }
end
