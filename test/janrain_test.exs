defmodule JanrainTest do
  use ExUnit.Case
  doctest Janrain

  test "returns failed for a bad token" do
    response = Janrain.authenticate_user_with "BAD TOKEN"
    assert {:failed} == response
  end

  @tag :skip
  test "returns a user profile if valid token" do
    # I swear I'll write a test for this
  end
end
