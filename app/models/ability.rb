class Ability
  include CanCan::Ability

  def initialize(current_user)
    current_user ||= User.new
    if current_user.roles.blank?
      cannot :update, :all
      cannot :read, :all
    elsif current_user.roles.to_s.include? "Manager"
      can :manage, :all
    elsif current_user.roles.to_s.include? "Editor"
      can [:read, :update, :create, :edit, :police, :cert, :applicants, :prospects, :other, :inactive, :leave, :declined], Person
      can [:read, :update, :create, :edit], Timecard
      can [:read, :update, :create, :edit], Channel
      can [:read, :update, :create, :edit], Cert
      can [:read, :update, :create, :edit], Item
      can [:read, :update, :create, :edit], Event
      can [:read, :update, :create, :edit], Course
      can [:read, :update, :create, :edit], Skill
      can [:read, :update, :create, :edit], Inspection
      can [:read, :update, :create, :edit], Location
      can [:read, :update, :create, :edit], Repair
      can [:read, :create], Activity
      can [:signin, :orgchart], Person
      can :read, :all
    elsif current_user.roles.to_s.include? 'Trainer'
      can [:read, :update, :create, :edit], Cert
      can [:read, :update, :create, :edit], Event
      can [:read, :update, :create, :edit], Course
      can [:read], [Person, Channel, Timecard, Item, Event, Course, Skill, Inspection, Repair]
      can [:signin, :orgchart], Person
      can [:read, :create], Activity
   elsif current_user.roles.to_s.include? 'Reader'
      can [:read], [Person, Channel, Timecard, Cert, Item, Event, Course, Skill, Inspection, Repair, Activity]
      can [:signin], Person
      can :orgchart, Person
    end
  end
end
