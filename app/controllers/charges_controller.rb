class ChargesController < ApplicationController
  def new
  end

  def create
    @amount = 100
    params[:client][:card] = params[:card_token]
    client = Espago.clients(:post, params[:client])

    charge = {     
      :client      => client["id"],
      :amount      => @amount,
      :description => 'Rails Espago client',
      :currency    => 'pln',
    }

    @charge = Espago.charges(:post, charge)
  end
end
