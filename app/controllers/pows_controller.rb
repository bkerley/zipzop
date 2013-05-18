class PowsController < ApplicationController
  helper_method :pow, :pow_id
  def index
    @pows = Pow.list
  end

  def show
    @tree = pow.tree
  end

  def pow_id
    params[:pow_id] || params[:id]
  end

  def pow
    @pow ||= Pow.new pow_id
  end
end
