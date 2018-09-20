module Api
  class BaseController < ActionController::API
    include ActionController::MimeResponds

    respond_to :json

    before_action :authorize

    private

    def authorize
      # TODO
    end

  end
end
