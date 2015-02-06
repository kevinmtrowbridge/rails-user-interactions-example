class User < ActiveRecord::Base
  has_many :outgoing_interactions, :class_name => "Interaction", :foreign_key => :from_user_id
  has_many :incoming_interactions, :class_name => "Interaction", :foreign_key => :to_user_id

  has_many :outgoing_requested_interactions,
           lambda { where("aasm_state = 'requested'") }, :class_name => "Interaction", :foreign_key => :from_user_id
  has_many :outgoing_denied_interactions,
           lambda { where("aasm_state = 'denied'") }, :class_name => "Interaction", :foreign_key => :from_user_id
  has_many :outgoing_matched_interactions,
           lambda { where("aasm_state = 'matched'") }, :class_name => "Interaction", :foreign_key => :from_user_id
  has_many :outgoing_confirmed_interactions,
           lambda { where("aasm_state = 'confirmed'") }, :class_name => "Interaction", :foreign_key => :from_user_id

  has_many :incoming_requested_interactions,
           lambda { where("aasm_state = 'requested'") }, :class_name => "Interaction", :foreign_key => :to_user_id
  has_many :incoming_denied_interactions,
           lambda { where("aasm_state = 'denied'") }, :class_name => "Interaction", :foreign_key => :to_user_id
  has_many :incoming_matched_interactions,
           lambda { where("aasm_state = 'matched'") }, :class_name => "Interaction", :foreign_key => :to_user_id
  has_many :incoming_confirmed_interactions,
           lambda { where("aasm_state = 'confirmed'") }, :class_name => "Interaction", :foreign_key => :to_user_id

  has_many :outgoing_interacted_users, :through => :outgoing_interactions, :source => :to_user
  has_many :incoming_interacted_users, :through => :incoming_interactions, :source => :from_user

  has_many :outgoing_requested_users, :through => :outgoing_requested_interactions, :source => :to_user
  has_many :outgoing_denied_users, :through => :outgoing_denied_interactions, :source => :to_user
  has_many :outgoing_matched_users, :through => :outgoing_matched_interactions, :source => :to_user
  has_many :outgoing_confirmed_users, :through => :outgoing_confirmed_interactions, :source => :to_user

  has_many :incoming_requested_users, :through => :incoming_requested_interactions, :source => :from_user
  has_many :incoming_denied_users, :through => :incoming_denied_interactions, :source => :from_user
  has_many :incoming_matched_users, :through => :incoming_matched_interactions, :source => :from_user
  has_many :incoming_confirmed_users, :through => :incoming_confirmed_interactions, :source => :from_user

  def requestable_users
    User.where "id NOT IN (?)", [self.id] + self.outgoing_requested_users.select(:id) + self.incoming_requested_users.select(:id)
  end
end
