Sequel.migration do
  change do
    add_column :packages, :hostname, String
  end
end
