require "hashie"

module Otc
  class ASGroup < Hashie::Dash
    class << self
      def query_all(name: nil)
        response = Request.get service: "as", path: "/autoscaling-api/v1/#{Configuration.project!}/scaling_group?scaling_group_name=#{name}"
        JSON.parse(response.body)["scaling_groups"].map do |group|
          ASGroup.new(group)
        end
      end

      def query_one(name: nil)
        query_all(name: name).first
      end
    end

    [
      "networks", "detail", "notifications", "scaling_group_name", "scaling_group_id", "scaling_group_status",
      "scaling_configuration_id", "scaling_configuration_name", "current_instance_number", "desire_instance_number",
      "min_instance_number", "max_instance_number", "cool_down_time", "lb_listener_id", "lbaas_listeners",
      "cloud_location_id", "available_zones", "security_groups", "create_time", "vpc_id", "health_periodic_audit_method",
      "health_periodic_audit_time", "instance_terminate_policy", "is_scaling", "delete_publicip"
    ].each { |prop| property prop }
  end
end
