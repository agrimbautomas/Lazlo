class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, ActiveAdmin::Page, name: "Dashboard"
    full_admin_roles if user.has_role? :full_admin
    blacksmith_roles user if user.has_role? :blacksmith
  end

  def full_admin_roles
    can :manage, :all
  end

  def blacksmith_roles user
    cannot :manage, :all
    can :manage, Order
    cannot :manage, AdminUser
  end
end
