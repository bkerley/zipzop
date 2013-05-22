class EditorsController < PowsController
  respond_to :html, :json
  helper_method :editable

  def show
    @data = editable.read
    respond_with do |f|
      f.html
      f.json do
        render json: {editable: editable, data: @data}
      end
    end
  end

  private

  def editable
    @editable ||= pow.editable path
  end

  def path
    @path ||= params[:id]
  end
end
