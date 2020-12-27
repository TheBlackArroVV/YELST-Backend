Sequel.migration do
  change do
    add_column :users, :uuid, String
  end
end
