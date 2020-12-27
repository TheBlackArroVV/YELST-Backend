Sequel.migration do
  change do
    create_table? :users do
      primary_key :id
      String :email
      String :encrypted_password
    end
  end
end
