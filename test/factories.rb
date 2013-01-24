# encoding: utf-8
require 'factory_girl'

FactoryGirl.define do

  factory :user do
    sequence(:name) {|n| "User#{n}"}
    title { "#{name} title" }
    email { "#{name}@email.com" }
    password { "#{name}-secret"}
    password_confirmation { password }
    admin false
  end

  factory :group do
    sequence(:name) {|n| "Group#{n}" }
    title { "#{name} title" }
    summary { "#{name} summary" }
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

  factory :phase do
    sequence(:title_es) {|n| "Fase es #{n}"}
    sequence(:title_ca) {|n| "Fase ca #{n}"}
    summary { "#{title_es} summary" }
  end

  factory :category do
    sequence(:name) {|n| "Category #{n}" }
    title { "#{name} title" }
    user
    phase
  end

  factory :proposal do
    sequence(:title) {|n| "Proposal #{n}"}
    summary { "#{title} summary" }
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
    summary { "#{title} summary" }
    user
  end

  factory :message do
    sequence(:body) {|n| "Message body #{n}" }
    user
  end

  factory :link do
    sequence(:url) {|n| "http://mquc.org/#{n}" }
    document  factory: :experiencie
    user
  end

  factory :image do
    sequence(:title) {|n| "Image #{n}" }
    external_image_url 'http://en.com/im.jpg'
    imageable factory: :experiencie
  end
end
