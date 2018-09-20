class ApplicationRecord < ActiveRecord::Base
  include FineGrainedValidations

  self.abstract_class = true
end
