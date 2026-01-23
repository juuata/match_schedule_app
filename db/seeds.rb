# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 初期ユーザーデータ
users = [
  { name: "田中太郎", email: "tanaka@example.com" },
  { name: "佐藤花子", email: "sato@example.com" },
  { name: "山田次郎", email: "yamada@example.com" }
]

users.each do |user_attrs|
  User.find_or_create_by!(email: user_attrs[:email]) do |user|
    user.name = user_attrs[:name]
  end
end

puts "Created #{User.count} users"
