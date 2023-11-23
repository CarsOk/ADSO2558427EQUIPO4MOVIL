class Order < ApplicationRecord
  has_many :packs, dependent: :destroy
  accepts_nested_attributes_for :packs, allow_destroy: true, reject_if: proc { |att| att['tipo'].blank? }
  belongs_to :dispatch, optional: true
  belongs_to :user
  belongs_to :company
  attribute :valor, :decimal, default: 0
  before_save :generate_shipping_code
  before_create :set_fecha
  private 
  
  def generate_shipping_code
    self.codigo_envio = SecureRandom.hex(10).upcase
  end

  def set_fecha
    self.fecha = Date.current
  end
end