# encoding: utf-8
require 'factory_girl'

FactoryGirl.define do

  factory :user do
    sequence(:name) {|n| "User#{n}"}
    email { "#{name}@email.com" }
    password { "#{name}-secret"}
    password_confirmation { password }
    admin false
  end

  factory :group do
    sequence(:name) {|n| "Group#{n}" }
    user
  end

  factory :content do
    sequence(:title) {|n| "Content #{n}" }
    user
    group
    body_type 'markdown'
  end

  factory :post, parent: :content, class: Post do
  end

  factory :page, parent: :content, class: Page do
  end

  factory :phase do
    sequence(:title_es) {|n| "Fase es #{n}"}
    sequence(:title_ca) {|n| "Fase ca #{n}"}
    summary { "#{title_es} summary" }
  end

  factory :category do
    sequence(:title) {|n| "Category #{n}" }
    question { "#{title} question" }
    user
    phase
  end

  factory :proposal do
    sequence(:title) {|n| "Proposal #{n}"}
    body { "#{title} body" }
    user
    category
  end

  factory :section do
    sequence(:title) {|n| "Section #{n}" }
    body { "#{title} body" }
    body_type 'markdown'
    lang 'es'
  end

  factory :experiencie do
    sequence(:title) {|n| "Experiencie #{n}" }
    body { "#{title} body" }
    user
  end

  factory :message do
    sequence(:body) {|n| "Message body #{n}" }
    user
  end

  factory :announcement do
    sequence(:title) {|n| "Announcement #{n}" }
    body { "#{title} body" }
    user
    group
  end
end
