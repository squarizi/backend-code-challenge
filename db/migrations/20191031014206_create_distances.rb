Hanami::Model.migration do
  change do
    create_table :distances do
      primary_key :id
      column :origin, String, null: false, size: 60
      column :destination, String, null: false, size: 60
      column :kilometers, Integer, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      index :origin
      index :destination
      index [:origin, :destination], unique: true, name: :stores_points_index
    end
  end
end
