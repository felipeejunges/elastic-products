# frozen_string_literal: true

class ImportProductJob < ApplicationJob
  include Sidekiq::Job

  def perform(*args)
    Product.__elasticsearch__.create_index!
    Product.import
  end
end