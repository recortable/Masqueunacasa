# encoding: utf-8
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

  factory :page, parent: :content, class: Page do
  end

  factory :phase do
    sequence(:name_es) {|n| "Fase es #{n}"}
    sequence(:name_ca) {|n| "Fase ca #{n}"}
    description_es { "#{name_es} descripción" }
    description_ca { "#{name_ca} descripciò" }
  end

  factory :proposal do
    sequence(:title) {|n| "Proposal #{n}"}
    body { "#{title} body" }
    user
    phase
  end

  factory :message do
    sequence(:body) {|n| "Message body #{n}" }
    user
  end
end
