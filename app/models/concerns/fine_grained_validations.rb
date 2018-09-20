module FineGrainedValidations
  extend ActiveSupport::Concern

  def has_error?(attribute, kind = nil)
    if kind
      errors.details[attribute].any? { |error_detail| error_detail[:error] == kind }
    else
      errors[attribute].any?
    end
  end

end
