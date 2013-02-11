require 'spec_helper'

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
  let( :bit ) do
    bit = mock_model( 'Bit' )
    bit
  end

  let( :controller ) { BitController.new(bit) }

  it "has expose resource method" do
    expect( BitController ).to respond_to :expose_resource
  end

  it "has resource_name method" do
    expect( controller.resource_name ).to eq 'bit'
  end

  it "has resource class methos" do
    expect( controller.resource_class ).to eq Bit
  end

  it "has bang methods" do
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
    resp = options[:response] || bit

    bit.should_receive(options[:expect]).and_return(true) if options[:expect]
    controller.send("#{name}!")
    #bit.verify if options[:expect]   ## no he encontrado el equivalente de esta sentencia en rspec, creo que no existe.

    expect( controller.auth[:action] ).to eq action
    if options[:resource]
      expect( controller.auth[:resource] ).to eq options[:resource]
    else
      expect( controller.auth[:resource] === resp ).to be_true
    end
    expect( controller.response === resp ).
      to be_true unless options[:response] == false
  end
end
