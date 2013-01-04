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
      can [:read, :update, :create, :edit], Course
      can [:read, :update, :create, :edit], Skill
      can [:read, :update, :create, :edit], Inspection
      can [:read, :update, :create, :edit], Location
      can [:read, :update, :create, :edit], Repair
      can [:signin], Person
      #can :update, People
      can :read, :all
    elsif current_user.roles.to_s.include? 'Reader'
      can :read, [Person, Cert, Item, Event, Course, Skill, Inspection, Repair]
      can [:signin], Person

    end
    #can :signin, :people
 #   can :manage, :all
  end
end