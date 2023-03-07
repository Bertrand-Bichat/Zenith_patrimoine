class PagePolicy < Struct.new(:user, :page)

  def home?
    true
  end

  def admin_dashboard_users?
    super_admin?
  end

  def admin_dashboard_criteria?
    super_admin?
  end

  def admin_dashboard_customers?
    authorized?
  end

  def wait?
    user_loggedin? && !user.authorized?
  end

  def client_files?
    authorized?
  end

  def user_authorized?
    super_admin?
  end

  def user_assistant?
    super_admin?
  end

  def user_admin?
    super_admin?
  end

  def assistant?
    super_admin?
  end

  def super_admin?
    user_loggedin? && user.super_admin?
  end

  def admin?
    user_loggedin? && user.admin?
  end

  def authorized?
    user_loggedin? && user.authorized?
  end

  def user_loggedin?
    user != nil
  end
end
