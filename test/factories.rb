require 'factory_girl'

FactoryGirl.define do
  factory :agent do
    sequence(:name) {|n| "Agent#{n}"}
  end

  factory :user, parent: :agent, class: User do
    email { "#{name}@email.com" }
    password { "#{name}-secret"}
    password_confirmation { "#{name}-secret"}
  end

  factory :group, parent: :agent, class: Group do
  end
end
