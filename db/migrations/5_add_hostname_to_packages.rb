Sequel.migration do
  change do
    add_column :packages, :hostname, 'string'
  end
end
