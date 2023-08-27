module Api
  class BaseController < ActionController::API
    include ActionController::MimeResponds

    respond_to :json

    before_action :authorize

    private

    def authorize
      api_key = request.headers['Authorization']
      @api_key = ApiKey.find_by(key: api_key, revoked: false)
  
      unless @api_key
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  end
end
