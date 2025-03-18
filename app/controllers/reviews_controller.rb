class ReviewsController < ApplicationController
    before_action :set_product

    def create
      @review = @product.reviews.build(review_params)
      if @review.save
        redirect_to @product, notice: "Review added!"
      else
        redirect_to @product, alert: "Error adding review."
      end
    end

    private

    def set_product
      @product = Product.find(params[:product_id])
    end

    def review_params
      params.require(:review).permit(:content, :rating)
    end
end
