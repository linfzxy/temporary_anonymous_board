class ArticlesController < ApplicationController
  def distribute
    render params[:id]
  end
end
