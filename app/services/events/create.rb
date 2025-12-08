# frozen_string_literal: true

module Events
  class Create < Base
    def call
      new_event = Event.new(sanitize_params)

      return new_event if new_event.save

      raise ::CustomException.new('cannot save this event', 422, new_event.errors.full_messages.join(', '))
    end

    def sanitize_params
      @params.permit(:title, :description).merge(author_id: @params[:session_user].id)
    end
  end
end
