class ChargesController < ApplicationController
  def new
  end

  def create
    @amount = 100
    # @product = Product.find(params[:product_id])

    client = Espago.clients(:post, params[:client])

    charge = Espago.charges(:post,
      :client      => client["id"],
      :amount      => @amount,
      :description => 'Rails Espago client',
      :currency    => 'pln'
    )
  end
end
