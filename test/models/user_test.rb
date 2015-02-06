require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "the truth" do
    alice = User.create(:username => 'alice')
    bob = User.create(:username => 'bob')
    kevin = User.create(:username => 'kevin')

    Interaction.create(:from_user => alice, :to_user => bob)

    assert alice.requestable_users.include?(kevin)
    assert !alice.requestable_users.include?(bob)
  end
end
