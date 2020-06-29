class PortfoliosController < ApplicationController
  def index
    @portfolio = Portfolio.enabled.not_home.order(created_at: :desc)
    @portfolios = @portfolio.paginate({page: params[:page], per_page:4})
  end

  def show
    @portfolio_order = Portfolio.created.order_portfolio_at((Portfolio.find params[:id]))
    @portfolio = Portfolio.find params[:id]
    set_meta_tags @portfolio.metatags
  end
end
