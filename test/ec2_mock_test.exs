defmodule Ec2MockTest do
  use ExUnit.Case
  doctest Ec2Mock

  test "product tag" do
    assert Ec2Mock.Ec2InstanceMetadata.serve_metadata(["meta-data", "tags", "instance", "product"]) ==
             "instance_product"
  end
end
