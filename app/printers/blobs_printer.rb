class BlobsPrinter < Blueprinter::Base
  identifier :key, name: :id
  field :data do |_user, options| 
    options[:data] 
  end
  field :byte_size
  field :created_at
end
