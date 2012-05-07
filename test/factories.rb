require 'factory_girl'

FactoryGirl.define do

  factory :user do
    sequence(:name) {|n| "User#{n}"}
    email { "#{name}@email.com" }
    password { "#{name}-secret"}
    password_confirmation { password }
  end

  factory :group do
    sequence(:name) {|n| "Group#{n}" }
    user
  end

  factory :content do
    sequence(:title) {|n| "Content #{n}" }
    user
    group
  end

  factory :post, parent: :content, class: Post do
  end
end
