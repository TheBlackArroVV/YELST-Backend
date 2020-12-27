Sequel.migration do
  change do
    create_table? :packages do
      primary_key :id
      foreign_key :user_id
    end
  end
end
