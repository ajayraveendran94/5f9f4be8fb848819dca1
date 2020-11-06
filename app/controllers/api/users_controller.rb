# frozen_string_literal: true

class Api::UsersController < ApplicationController
  
  def index
    users = User.all
    render json: users, status: :ok
  end

  def show
    find_user
    if @user.present?
      render json: @user, status: :ok
    else
      render json: {
        errors: 'user not found'
      }, status: :not_found
    end
  end

  def create
    user = User.new(user_details)
    if user.save
      render json: user, status: :created
    else
      render json: {
        errors: user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    find_user
    if @user.present?
      @user.first.update(user_details)
      render json: {
        message: 'update success',
        data: @user
      }
    else
      render json: {
        errors: 'user not found'
      }, status: :not_found
    end
  end

  def destroy
    find_user
    if @user.present?
      @user.first.destroy(user_details)
      render json: {
        message: 'success',
        data: @user
      }
    else
      render json: {
        errors: 'user not found'
      }, status: :not_found
    end
  end

  def typeahead
    users = User.any_of({ firstName: params[:input] }, { lastName: params[:input] }, { email: params[:input] })
    render json: {
      message: 'success',
      data: users
    }
  end

  def find_user
    @user = User.where(id: params[:id].to_i)
  end

  private

  def user_details
    params.permit(:email, :firstName, :lastName)
  end
end