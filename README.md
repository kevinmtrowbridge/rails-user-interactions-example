## Examples copy-pasted from test/models/user_test.rb

```
setup do
  %w(Noah Liam Jacob Mason William Ethan Michael Alexander Jayden Daniel).each do |boy|
    User.create(:username => boy, :gender => "M", :seeking => ["M", "F"].sample)
  end

  %w(Sophia Emma Olivia Isabella Ava Mia Emily Abigail Madison Elizabeth).each do |girl|
    User.create(:username => girl, :gender => "F", :seeking => ["M", "F"].sample)
  end
end

test "#requestable_users scope does not include self" do
  u = User.first
  assert !u.requestable_users.include?(u)
end

test "#requestable_users scope includes only users of 'seeking' gender" do
  u = User.first
  requested_genders = u.requestable_users.collect{|u| u.gender}.uniq
  assert requested_genders.count == 1
  assert requested_genders[0] == u.seeking
end

test "#requestable_users, outgoing_denied_users do not appear" do
  alice = User.first
  bob = alice.requestable_users.first

  assert alice.requestable_users.include?(bob)

  interaction = Interaction.create(:from_user => alice, :to_user => bob)
  interaction.deny

  assert !alice.requestable_users.include?(bob)
  alice.outgoing_denied_users.include?(bob)
  bob.incoming_denied_users.include?(alice)
end
```