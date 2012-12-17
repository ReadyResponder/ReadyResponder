class Ability
  include CanCan::Ability
  
  def initialize(current_user)
    current_user ||= User.new
    if current_user.role? :Manager
      can :manage, :all
    elsif current_user.roles.to_s.include? "Editor"
      can [:read, :update, :create, :edit], Person
      can [:read, :update, :create, :edit], Cert
      can [:read, :update, :create, :edit], Item
      can [:read, :update, :create, :edit], Event
      #can :update, People
      can :read, :all
    elsif current_user.roles.to_s.include? 'Reader'
      can :read, [Person, Cert]
    end
    #can :signin, :people
 #   can :manage, :all
  end
end