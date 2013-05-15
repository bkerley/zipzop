class EditorsController < ApplicationController
  def show
    @file = Rails.root.join 'config', 'routes.rb'
    @data = File.read @file
  end
end
