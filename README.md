This tutorial will get you up and running with Espago’s Charge and Rails in no time at all.

The first step is adding the Espago gem to you Rails application’s **Gemfile**:

    gem 'espago', :git => 'https://github.com/espago/espago' 

Run bundle install, and then lets generate a new Charges controller.

    $ rails g controller charges

The controller is going to do two things. Show a credit card form, and create the actual charges:

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

## Routes

Users need to be able to access our newly created controller, so lets add a route to it in **config/routes.rb**:

    resources :charges

##Configuration

We need to setup Espago’s API key before we can use the API. Let’s do this in an initializer. Add the following to **config/initializers/espago.rb**

    Espago.app_id = ENV['ESPAGO_APP_ID']
    Espago.app_password = ENV['ESPAGO_PASSWORD']
    Espago.public_key = ENV['ESPAGO_PUBLIC_KEY']
    Espago.production = false #sets Espago enviroment to sandbox

We’re pulling these keys out of environmental variables so as not to hardcode them. It’s often bad practice to put sensitive data into source control.

##Views

Let’s create **new.html.erb** under **app/views/charges**, which is going to be our checkout page. It's also going to handle form display

    <%= form_tag charges_path do %>
      <div>
        <%= label_tag :clients_email %>
        <%= text_field_tag "client[email]" %>
      </div>
        <%= label_tag :clients_description %>
        <%= text_field_tag "client[description]" %>
      <div>
        <%= label_tag :clients_card_first_name %>
        <%= text_field_tag "client[card][first_name]" %>
      </div>
      <div>
        <%= label_tag :clients_card_last_name %>
        <%= text_field_tag "client[card][last_name]" %>
      </div>
      <div>
        <%= label_tag :clients_card_number %>
        <%= text_field_tag "client[card][number]" %>
      </div>
      <div>
        <%= label_tag :clients_card_month %>
        <%= text_field_tag "client[card][month]" %>
      </div>
      <div>
        <%= label_tag :clients_card_year %>
        <%= text_field_tag "client[card][year]" %>
      </div>
      <div>
        <%= label_tag :clients_card_verfication_value %>
        <%= text_field_tag "client[card][verification_value]" %>
      </div>
      <div>
        <%= submit_tag "ok" %>
      </div>
    <% end %>

Finally let’s make a **create.html.erb** view under **app/views/charges** that shows users a success message.

    <h2>Thanks, you paid <strong><%= @amount%></strong>!</h2>

And that’s a wrap, Espago and Rails integration in a matter of minutes.
