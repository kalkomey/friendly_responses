require "friendly_responses/version"

module FriendlyResponses

  class ValidModelError < StandardError
  end


  # Renders a friendly JSON error response
  def respond_with_invalid_record(model)
    model_name = model.class.name.underscore.to_sym

    if model.valid?
      raise ValidModelError.new "can't render error response for valid model"
    end

    render status: :unprocessable_entity,
      json: {
        errors: model.errors.full_messages,
        model_name => { errors: model.errors }
      }
  end

end
