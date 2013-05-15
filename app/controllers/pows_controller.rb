class PowsController < ApplicationController
  def pow
    @pow ||= Pow.new params[:pow_id]
  end
end
