Sequel.migration do
  change do
    add_column :packages, :list, 'text[]'
  end
end
