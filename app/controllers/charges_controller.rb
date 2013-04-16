class ChargesController < ApplicationController
  def new
  end

  def create
    @amount = 100
    # @product = Product.find(params[:product_id])

    client = Espago.clients(:post, params[:client])

    charge = {     
      :client      => client["id"],
      :amount      => @amount,
      :description => 'Rails Espago client',
      :currency    => 'pln',
    }

    charge[:transfer] = params[:transfer] if params[:transfer]
    charge[:cc] = params[:cc] if params[:cc]

    @charge = Espago.charges(:post, charge)
    
    redirect_to @charge["redirect_url"] if @charge["redirect_url"]
  end
end
