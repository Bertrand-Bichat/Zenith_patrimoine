class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  before_action :find_agents_without_delegation, only: [:admin_dashboard_criteria, :client_files]

  def home
    authorize :page, :home?

    if user_signed_in? && current_user.authorized?
      return redirect_to client_files_path
    elsif user_signed_in?
      return redirect_to wait_path
    else
      return redirect_to root_path
    end
  end

  def admin_dashboard_users
    authorize :page, :admin_dashboard_users?
    @users = User.all.order(id: :asc)
  end

  def admin_dashboard_criteria
    authorize :page, :admin_dashboard_criteria?

    @criterion = Criterion.new
    @instance_reasons = policy_scope(Criterion).where(column: helpers.instance_reason).order(id: :asc)
    @customer_classes = policy_scope(Criterion).where(column: helpers.customer_class).order(id: :asc)
    @prioritizations = policy_scope(Criterion).where(column: helpers.prioritization).order(id: :asc)
    @monitorings = policy_scope(Criterion).where(column: helpers.monitoring).order(id: :asc)
  end

  def admin_dashboard_customers
    authorize :page, :admin_dashboard_customers?
    @customer = Customer.new
    @agents = User.where(authorized: true).order(first_name: :asc)

    if current_user.super_admin? || current_user.admin?
      @customers = policy_scope(Customer).includes(:user).all.order(name: :asc)
    else
      @customers = current_user.customers.order(name: :asc)
    end
  end

  def wait
    authorize :page, :wait?
  end

  def client_files
    authorize :page, :client_files?
    @new_contract = Contract.new
    @last_contract = policy_scope(Contract).last

    @instance_reasons = policy_scope(Criterion).where(column: helpers.instance_reason).order(id: :asc)
    @customer_classes = policy_scope(Criterion).where(column: helpers.customer_class).order(id: :asc)
    @prioritizations = policy_scope(Criterion).where(column: helpers.prioritization).order(id: :asc)
    @monitorings = policy_scope(Criterion).where(column: helpers.monitoring).order(id: :asc)

    if current_user.super_admin? || current_user.admin?
      @agents = User.where(authorized: true).order(first_name: :asc)
      @assistants = User.where(assistant: true).order(first_name: :asc)
      @customers = policy_scope(Customer).order(id: :asc)
      @contracts = policy_scope(Contract).includes(customer: [user: [agent_delegation: :assistant]]).order(id: :desc)
      @contracts_size = @contracts.size
      @disabled = nil
      @role = 'admin'

      return @contract_numbers = find_contract_numbers(@contracts)
    elsif current_user.assistant?
      @agents = current_user.find_agents
      # @agents_customers = policy_scope(Customer).where(user_id: @agents).order(id: :asc)
      @agents_customers = current_user.find_agents_customers
      @user_customers = current_user.customers.order(id: :asc)
      @customers = @agents_customers

      # @agents_contracts = policy_scope(Contract).includes(customer: [user: [agent_delegation: :assistant]]).where(customer_id: current_user.find_agents_customers).order(id: :desc)
      @contracts = policy_scope(Contract).includes(customer: [user: [agent_delegation: :assistant]]).where(customer_id: @agents_customers).order(id: :desc)
      @contracts_size = @contracts.size
      @disabled = true
      @role = 'assistant'

      return @contract_numbers = find_contract_numbers(@contracts)
    else
      @customers = current_user.customers.order(name: :asc)
      @contracts = policy_scope(Contract).includes(customer: [user: [agent_delegation: :assistant]]).where(customer_id: current_user.customers).order(id: :desc)
      @contracts_size = @contracts.size
      @disabled = true
      @role = 'agent'

      # @contracts = current_user.customers.map { |customer| customer.contracts }. flatten
      return @contract_numbers = find_contract_numbers(@contracts)
    end
  end

  def user_authorized
    authorize :page, :user_authorized?

    @user = User.find(params[:id])
    @user.update(authorized: !@user.authorized)

    respond_to do |format|
      format.js
    end
  end

  def user_assistant
    authorize :page, :user_assistant?
    @user = User.find(params[:id])

    if @user.assistant?
      @user.update(assistant: false)
      @user.agent_delegation.destroy
    else
      @user.update(assistant: true)
      @user.agent_delegation&.destroy
      Delegation.create(assistant_id: @user.id, agent_id: @user.id)
    end

    respond_to do |format|
      format.js
    end
  end

  def user_admin
    authorize :page, :user_admin?

    @user = User.find(params[:id])
    @user.update(admin: !@user.admin)

    respond_to do |format|
      format.js
    end
  end

  def assistant
    authorize :page, :assistant?
    @user = User.find(params[:id])

    if @user.assistant?
      @delegation = Delegation.new
      @user_agents = @user.find_agents
      @agents = User.where(authorized: true, assistant: false, admin: false, super_admin: false).includes([:agent_delegation]).order(id: :asc).reject { |user| @user_agents.include?(user) || user.agent_delegation.present? }
    else
      return redirect_to admin_dashboard_users_path, alert: "Cet agent n'a pas les droits d'adjoint."
    end
  end

  private

  def find_contract_numbers(contracts)
    contracts.map { |contract| contract.contract_number }
  end
end
