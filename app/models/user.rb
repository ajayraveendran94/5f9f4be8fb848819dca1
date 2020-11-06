# frozen_string_literal: true

require 'autoinc'

class User
  include Mongoid::Document
  include Mongoid::Autoinc
  include Mongoid::Timestamps
  field :firstName, type: String
  field :lastName, type: String
  field :email, type: String
  increments :id
end
