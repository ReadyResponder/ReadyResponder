class Ability
  include CanCan::Ability

  def initialize(current_user)
    current_user ||= User.new
    roles = current_user.roles.map {|x| x.to_s}
    if roles.blank?
      cannot :manage, :all
      cannot [:read, :update, :create, :edit], :all
    elsif roles.include? "Manager"
      can :manage, :all
    elsif roles.include? "Editor"
      can [:read, :create], Activity
      can [:read, :update, :create, :edit], Assignment
      can [:read, :update, :create, :edit], Availability
      can [:read, :update, :create, :edit], Cert
      can [:read, :update, :create, :edit], Channel
      can [:read, :update, :create, :edit], Course
      can [:read, :update, :create, :edit, :orgchart], Department
      can [:read, :update, :create, :edit, :templates, :archives], Event
      can [:read, :update, :create, :edit], Inspection
      can [:read, :update, :create, :edit], Item
      can [:read, :update, :create, :edit], ItemCategory
      can [:read, :update, :create, :edit], ItemType
      can [:read, :update, :create, :edit], Location
      can [:read, :update, :create, :edit], Notification
      can [:read, :update, :create, :edit, :department, :download, :applicants,
           :prospects, :other, :inactive, :leave, :declined, :everybody, :signin
           ], Person
      can [:read, :update, :create, :edit], Repair
      can [:read, :update, :create, :edit], Requirement
      can [:read, :update, :create, :edit], Setting
      can [:read, :update, :create, :edit], Skill
      can [:read, :update, :create, :edit], Task
      can [:read, :update, :create, :edit, :verify], Timecard
      can [:read, :update, :create, :edit], Vendor
      can :read, :all
    elsif roles.include? 'Trainer'
      can [:read, :create], Activity
      can [:read, :update, :create, :edit], Cert
      can [:read, :update, :create, :edit], Course
      can [:read, :update, :create, :edit, :orgchart], Department
      can [:read, :update, :create, :edit, :templates, :archives], Event
      can [:signin, :orgchart], Person
      can [:read, :update, :create, :edit], Requirement
      can [:read, :update, :create, :edit], Task
      can [:read], [Person, Channel, Timecard, Item, Skill, Inspection, Repair]
      can [:read, :update, :create, :edit], Vendor
   elsif roles.include? 'Reader'
      can [:read], [Person, Channel, Timecard, Cert, ItemCategory, ItemType,
                    Item, Event, Task, Course, Skill, Inspection, Repair,
                    Activity, Department, Vendor]
      can [:templates, :archives], Event
      can [:signin, :download, :orgchart], Person
    end
  end
end
