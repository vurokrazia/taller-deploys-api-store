json.extract! user, :id, :email, :age, :created_at, :updated_at
json.store do
    json.partial! 'v1/stores/store', store: user.store
end