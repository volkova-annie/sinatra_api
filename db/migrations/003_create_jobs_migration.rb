Sequel.migration do
  change do
    create_table!(:jobs) do
      primary_key :id
      String :place, :text=>true, :null => false
      String :name, :text=>true, :null => false
      foreign_key :company_id, :companies, :null => false, :key=>[:id]

      DateTime :created_at
      DateTime :upated_at

      index :id

    end
  end
end