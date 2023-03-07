class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients, id: :uuid do |t|
      t.string :secret
      t.string :token # to simplify the project i used field rather than client_tokens table
      t.string :name
      t.string :experied_at
      t.timestamps
    end
  end
end