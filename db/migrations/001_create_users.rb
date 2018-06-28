# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :users do
      primary_key :id
      Integer :github_uid
      String :name
      String :avatar_url
      String :github_access_token
    end
  end
end
