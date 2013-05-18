class PowsController < ApplicationController
  def index
    @pows = Pow.list
  end
  def pow
    @pow ||= Pow.new params[:pow_id]
  end
end
