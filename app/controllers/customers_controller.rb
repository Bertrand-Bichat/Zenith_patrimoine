class CustomersController < ApplicationController
  before_action :find_customer, only: [:edit, :update]

  def create
    @customer = Customer.new(customer_params)
    authorize @customer

    unless current_user.admin? || current_user.super_admin?
      @customer.user = current_user
    end

    if @customer.save
      return redirect_to admin_dashboard_customers_path, notice: 'Votre nouveau client a bien été créé.'
    else
      return redirect_to admin_dashboard_customers_path, alert: 'Erreur de saisie'
    end
  end

  def edit
    @agents = User.where(authorized: true).order(id: :asc)
  end

  def update
    if @customer.update(customer_params)
      return redirect_to admin_dashboard_customers_path, notice: 'Vos modifications ont bien été prises en compte.'
    else
      render :edit
    end
  end

  private

  def find_customer
    @customer = authorize policy_scope(Customer).find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :client_number, :user_id)
  end
end
