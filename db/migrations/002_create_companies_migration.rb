Sequel.migration do
  change do
    create_table!(:companies) do
      primary_key :id
      String :name, :text=>true, :null => false
      String :location, :text=>true, :null => false

      DateTime :created_at
      DateTime :upated_at

      index :id

    end
  end
end