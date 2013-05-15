class DirectoriesController < PowsController
  def show
    @tree = pow.tree
  end
end
