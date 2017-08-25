include ActionView::Helpers::AssetUrlHelper

order_status_image = File.new(File.join(Rails.root, 'app/assets/images/logos/logo-yellow.png'))
OrderStatus.create!(name: 'Encargada', priority: 1, image: order_status_image)

order_status_image = File.new(File.join(Rails.root, 'app/assets/images/logos/logo-violet.png'))
OrderStatus.create!(name: 'En Herrería', priority: 2, image: order_status_image)

order_status_image = File.new(File.join(Rails.root, 'app/assets/images/logos/logo-green.png'))
OrderStatus.create!(name: 'En pinturería', priority: 3, image: order_status_image)

order_status_image = File.new(File.join(Rails.root, 'app/assets/images/logos/logo-red.png'))
OrderStatus.create!(name: 'Listo para entregar!', priority: 4, image: order_status_image)

order_status_image = File.new(File.join(Rails.root, 'app/assets/images/logos/logo-multi.png'))
OrderStatus.create!(name: 'Entregada', priority: 5, image: order_status_image)

admin1 = AdminUser.create!(email: 'tomas@theamalgama.com', password: 'sinclair2955', password_confirmation: 'sinclair2955')
admin1.add_role :full_admin

admin2 = AdminUser.create!(email: 'tomas@macain.com.ar', password: 'sinclair2955', password_confirmation: 'sinclair2955')
admin2.add_role :full_admin

Buyer.create!(name: 'John Buyer', email: 'john@buyer.com')

category1 = Category.create!(name: 'Mesa Ratona')
category2 = Category.create!(name: 'Mesa Comedor')

Product.create!(name: 'A fake Product', description: 'Some random description, some random description',
                price: 2000, category: category1)

Product.create!(name: 'Another fake Product', description: 'Some random description, some random description',
                price: 5000, category: category1)

Product.create!(name: 'Product Of some other kind', description: 'Some random description, some random description',
                price: 5000, category: category2)