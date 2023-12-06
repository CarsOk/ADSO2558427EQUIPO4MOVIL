class Order < ApplicationRecord
  has_many :packs, dependent: :destroy
  # accepts_nested_attributes_for :packs, allow_destroy: true, reject_if: proc { |att| att['tipo'].blank? }
  belongs_to :dispatch, optional: true
  belongs_to :user
  belongs_to :company
  attribute :valor, :decimal, default: 0
end
