class PaymentsController < ApplicationController
    def create
      @product = Product.find(params[:product_id])
      @session = Stripe::Checkout::Session.create(
        payment_method_types: [ "card" ],
        line_items: [ {
          price_data: {
            currency: "usd",
            product_data: { name: @product.name },
            unit_amount: (@product.price * 100).to_i
          },
          quantity: 1
        } ],
        mode: "payment",
        success_url: checkout_success_url,
        cancel_url: checkout_cancel_url
      )
      redirect_to @session.url, allow_other_host: true
    end

    def success
      flash[:notice] = "Payment successful!"
      redirect_to root_path
    end

    def cancel
      flash[:alert] = "Payment canceled."
      redirect_to root_path
    end
end
