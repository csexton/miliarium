# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :labels do
      primary_key :id
      String :name
      String :repo_url
    end
  end
end
