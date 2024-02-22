class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, Product, user: user
    elsif user.employee?
      can :read, Product, user: 'employee'
      can :update,Product, user: 'employee'
      cannot? :destroy,Product
    end
  end
end
