# frozen_string_literal: true

module Admin
  class ListAllUsers
    def initialize(params)
      @params = params
    end

    def call
      limit = 10
      page = (@params[:page].presence || 1).to_i
      skip = (page * limit) - limit
      User.offset(skip).limit(limit)
    end
  end
end
