# frozen_string_literal: true

class Repository < ApplicationRecord
  include AASM

  validates :link, presence: true, uniqueness: true

  aasm do
    state :created, initial: true
    state :fetching, :fetched, :failed

    event :start_fetch do
      transitions from: %i[created fetched failed], to: :fetching
    end

    event :finish_fetch do
      transitions from: :fetching, to: :fetched
    end

    event :fail_fetch do
      transitions from: :fetching, to: :failed
    end
  end
end