class EditorsController < ApplicationController
  def show
    # render text: path
    @data = editable.read
  end

  private
  def pow
    @pow ||= Pow.new params[:pow_id]
  end

  def editable
    @editable ||= pow.editable path
  end

  def path
    @path ||= params[:id] + '.' + params[:format]
  end
end
