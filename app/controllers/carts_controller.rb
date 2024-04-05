# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_cart, only: %i[show add remove]
  def create
    @cart = Cart.create
    render :show, status: :created
  end

  def show; end

  def add
    @item = Item.find_by(id: params[:item_id])
    unless @item
      return render json: { status: :unprocessable_entity, message: "Item not found" },
                    status: :unprocessable_entity
    end

    @cart_item = @cart.cart_items.find_or_initialize_by(item_id: params[:item_id])
    @cart_item.quantity += 1
    if @cart_item.save
      render :update, locals: { message: "Item added to cart" }
    else
      render json: { status: :unprocessable_entity, message: @cart_item.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def remove
    @cart_item = @cart.cart_items.find_by(item_id: params[:item_id])
    unless @cart_item
      return render json: { status: :unprocessable_entity, message: "Item not found in cart" },
                    status: :unprocessable_entity
    end

    @cart_item.quantity -= 1
    if @cart_item.quantity.zero?
      @cart_item.destroy
    else
      @cart_item.save
    end

    render :update, locals: { message: "Item removed from cart" }
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end
end
