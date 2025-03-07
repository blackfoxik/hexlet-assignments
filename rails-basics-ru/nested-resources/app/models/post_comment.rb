# frozen_string_literal: true

class PostComment < ApplicationRecord
  belongs_to :post
end
