namespace :load do

    task :products => :environment do
        Product.all.delete_all
        line_num=0
        File.open('products.json').each do |line|
            line.strip!
            if line[0] == '['
                line[0] = ''
            end
            if line[-1] == ','
                line[-1] = ''
            end

            if line[-1] == ']'
                line[-1] = ''
            end


            product = JSON.parse line

            new_product = Product.new
            new_product.name = product['name']
            new_product.sku = product['sku']
            new_product.description = product['description']
            new_product.manufacturer = product['manufacturer']
            new_product.save
        end
    end

    task :large_products => :environment do
        Product.all.delete_all
        3000000.times.each do |i|
            new_product = Product.new
            uuid = SecureRandom.uuid
            new_product.name = uuid
            # new_product.sku = uuid
            new_product.description = uuid
            new_product.manufacturer = uuid
            new_product.save
        end
    end

    task :elasticsearch => :environment do
        Product.__elasticsearch__.create_index! force: true
        Product.__elasticsearch__.import
    end

end
