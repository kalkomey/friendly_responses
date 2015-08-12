require 'spec_helper'

class FakeController
  attr_reader :render_options
  include FriendlyResponses

  def render(*args, &block)
    @render_options = args
  end
end

class FakeModel
  attr_accessor :name
  include ActiveModel::Validations
  validates :name, presence: true
end

describe FriendlyResponses do
  it 'has a version number' do
    expect(FriendlyResponses::VERSION).not_to be nil
  end

  describe '#respond_with_invalid_record' do
    let(:controller) { FakeController.new }
    let(:invalid_model) { FakeModel.new }

    it 'renders an error response' do
      invalid_model.valid?
      controller.respond_with_invalid_record invalid_model
      expect(controller.render_options.size).to eq(1)

      status = controller.render_options.first[:status]
      expect(status).to eq(:unprocessable_entity)

      body = controller.render_options.first[:json]
      expect(body[:errors]).to eq(["Name can't be blank"])

      expect(body[:fake_model][:errors][:name]).to eq(["can't be blank"])
    end

    it 'raises when model is valid' do
      valid_model = FakeModel.new
      valid_model.name = 'foo'

      expect(-> {
        controller.respond_with_invalid_record valid_model
      }).to raise_error(FriendlyResponses::ValidModelError)
    end
  end
end
