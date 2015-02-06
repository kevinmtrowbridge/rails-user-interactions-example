class Interaction < ActiveRecord::Base
  include AASM

  belongs_to :from_user, :class_name => "User"
  belongs_to :to_user, :class_name => "User"

  aasm do
    state :requested, :initial => true
    state :denied
    state :matched
    state :confirmed

    event :deny do
      transitions :from => :requested, :to => :denied
    end

    event :accept_match do
      transitions :from => :requested, :to => :matched
    end

    event :confirm_match do
      transitions :from => :matched, :to => :confirmed
    end
  end
end