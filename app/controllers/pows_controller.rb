class PowsController < ApplicationController
  respond_to :html, :json

  helper_method :pow, :pow_id
  def index
    @pows = Pow.list
    respond_with do |f|
      f.html
      f.json do
        raw = @pows.as_json exclude: [:tree]
        pathed = raw.map do |h|
          h[:path] = pow_path(h[:name], format: :json) unless h[:broken]
          h
        end
        render json: pathed
      end
    end
  end

  def show
    @tree = pow.tree
    respond_with pow
  end

  def pow_id
    params[:pow_id] || params[:id]
  end

  def pow
    @pow ||= Pow.new pow_id
  end
end
