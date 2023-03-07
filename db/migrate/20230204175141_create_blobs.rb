class CreateBlobs < ActiveRecord::Migration[6.1]
  def change
    create_table :blobs do |t|
      t.string   :key, null: false
      t.string   :filename
      t.boolean :uploaded
      t.string   :content_type
      t.text     :metadata
      t.bigint   :byte_size
      t.references :client, foreign_key: true, type: :uuid
      t.integer  :service_type
      t.timestamps
    end
  end
end
