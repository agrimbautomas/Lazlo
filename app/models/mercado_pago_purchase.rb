# == Schema Information
#
# Table name: mercado_pago_purchases
#
#  id            :integer          not null, primary key
#  collection_id :string(255)
#  preference_id :string(255)
#  payment_type  :string(255)
#  status        :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

### Mercado Pago States ###
# pending: usuario aún no completó el proceso de pago.
# approved: El pago fue aprobado y acreditado.
# in_process: El pago está siendo revisado.
# in_mediation: Los usuarios tienen iniciada una disputa.
# rejected: El pago fue rechazado. El usuario puede intentar pagar nuevamente.
# cancelled: El pago fue cancelado por una de las partes, o porque el tiempo expiró.
# refunded: El pago fue devuelto al usuario.
# charged_back: Fue hecho un contracargo en la tarjeta del pagador.

class MercadoPagoPurchase < ApplicationRecord

  belongs_to :order

  enum status: [:pending, :approved, :in_process, :in_mediation,
                :rejected, :cancelled, :refunded, :charged_back]

end
