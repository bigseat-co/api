# frozen_string_literal: true

# base for all the models
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
