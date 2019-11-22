# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show; end

  def edit; end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: I18n.t(:reg_success)
    else
      render 'new'
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :crypted_password,
      :crypted_password_confirmation
    )
  end
end
