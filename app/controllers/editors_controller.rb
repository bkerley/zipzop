class EditorsController < PowsController
  def show
    # render text: path
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
