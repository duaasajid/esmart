module Api
  class BaseController < ActionController::API
    respond_to :json

    before_action :authorize

    private

    def authorize
      # TODO
    end

  end
end
