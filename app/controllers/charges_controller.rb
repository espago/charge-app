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

    charge[:trasnfer] = params[:transfer] if params[:trasnfer]
    charge[:cc] = params[:cc] if params[:cc]

    @charge = Espago.charges(:post, charge)
  end
end
