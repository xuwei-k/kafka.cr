require "./spec_helper"

describe Kafka::Protocol::HeartbeatRequest do
  it "to_kafka" do
    req = Kafka::Protocol::HeartbeatRequest.new(0, "x", "y", -1, "cr")
    bin = req.to_slice
    bin.should eq(bytes(0, 0, 0, 22, 0, 12, 0, 0, 0, 0, 0, 0, 0, 1, 120, 0, 1, 121, 255, 255, 255, 255, 0, 2, 99, 114))
  end
end

describe Kafka::Protocol::HeartbeatResponse do
  it "from_kafka" do
    res = Kafka::Protocol::HeartbeatResponse.from_kafka(bytes(0, 0, 0, 6, 0, 0, 0, 0, 0, 16))
    res.correlation_id.should eq(0)
    res.error_code.should eq(16)
  end
end
