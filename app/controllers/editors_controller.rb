class EditorsController < PowsController
  helper_method :editable
  def show
    @data = editable.read
  end

  private

  def editable
    @editable ||= pow.editable path
  end

  def path
    @path ||= params[:id]
  end
end
