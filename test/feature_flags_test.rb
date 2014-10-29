require 'test_helper'

class FeatureFlagsTest < ActiveSupport::TestCase
  test "the set of available flags should be available" do
    user = User.create(name: "myuser")
    assert user.available_features.include?(:awesome_feature)
    assert user.available_features.include?(:other_feature)
    assert !user.available_features.include?(:lame_feature)
  end

  test "flags can be checked" do
    user = User.create(name: "myuser")
    assert !user.awesome_feature_enabled?
    user.enable_awesome_feature!
    assert user.awesome_feature_enabled?
    user.disable_awesome_feature!
    assert !user.awesome_feature_enabled?
  end

  test "flags must be disabled by default" do
    user = User.create(name: "myuser")
    assert !user.feature_enabled?(:awesome_feature)
    assert !user.feature_enabled?(:lame_feature)
    assert !user.feature_enabled?(:other_feature)
  end

  test "flags can be enabled" do
    user = User.create(name: "myuser")
    assert !user.feature_enabled?(:awesome_feature)
    user.enable_feature!(:awesome_feature)
    assert user.feature_enabled?(:awesome_feature)
  end

  test "flags can be disabled" do
    user = User.create(name: "myuser", features: { "awesome_feature" => true })
    user.disable_feature!(:awesome_feature)
    assert !user.feature_enabled?(:awesome_feature)
  end

  test "flags can be stored in a custom field" do
    user = AltUser.create(name: "myuser", flags: { "awesome_feature" => true })
    assert user.awesome_feature_enabled?
  end

  test "all flags can be enabled with a master feature" do
    user = AltUser.create(name: "myuser", flags: { "awesome_feature" => false })
    assert !user.master_feature_enabled?
    assert !user.awesome_feature_enabled?
    user.enable_master_feature!
    assert user.master_feature_enabled?
    assert user.awesome_feature_enabled?
    user.disable_master_feature!
    assert !user.master_feature_enabled?
    assert !user.awesome_feature_enabled?
  end

end
