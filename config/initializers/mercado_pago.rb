#MercadoPago
require 'mercadopago.rb'

secrets = Rails.application.secrets
$mp_client = MercadoPago.new(secrets[:mercado_pago_client_id], secrets[:mercado_pago_secret_id])

