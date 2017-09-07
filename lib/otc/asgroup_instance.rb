require "hashie"

module Otc
  class ASGroupInstance < Hashie::Dash
    [
      "instance_id", "scaling_group_id", "scaling_group_name", "life_cycle_state", "health_status",
      "scaling_configuration_name", "scaling_configuration_id", "create_time", "instance_name"
    ].each { |prop| property prop }
  end
end
