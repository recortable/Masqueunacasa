require 'test_helper'

class Bit

end

class BitController
  include HasResource
  expose_resource :bit
  attr_reader :bit, :flash, :url_for, :response, :auth

  def initialize(bit)
    @bit = bit 
    @flash = {}
  end

  def bits
    'collection'
  end

  def url_for(resource)
    @url_for = resource
  end

  def t(translation, options = {})
    translation
  end

  def authorize!(action, resource)
    @auth = { action: action, resource: resource }
  end

  def respond_with(responded, options = {})
    @response = responded
    @location = options[:location]
  end
end

describe HasResource do
  let(:bit) do
    bit =  MiniTest::Mock.new 
    bit
  end
  let(:controller) { BitController.new(bit) }

  it 'has expose_resource method' do
    BitController.respond_to?(:expose_resource).must_equal true
  end

  it 'has resource_name method' do
    controller.resource_name.must_equal 'bit'
  end

  it 'has resource_class' do
    controller.resource_class.must_equal Bit
  end

  it 'has bangs methods' do
    verify_bang :index, :read, resource: Bit, 
      response: false
    verify_bang :show, :read
    verify_bang :new, :create
    verify_bang :edit, :update
    verify_bang :create, :create, expect: :save, 
      notice: 'bits.created'
    verify_bang :update, :update, expect: :save,
      notice: 'bits.updated'
    verify_bang :destroy, :destroy, expect: :destroy,
      notice: 'bits.destroyed'
  end

  def verify_bang(name, action, options = {})
    response = options[:response] || bit

    bit.expect options[:expect], true if options[:expect]
    controller.send("#{name}!")
    bit.verify if options[:expect]

    controller.auth[:action].must_equal action
    if options[:resource]
      controller.auth[:resource].must_equal options[:resource]
    else
      (controller.auth[:resource] === response).must_equal true
    end
    (controller.response === response).must_equal true unless options[:response] == false
  end
end
