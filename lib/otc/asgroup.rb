require "hashie"

module Otc
  class ASGroup < Hashie::Mash
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

    def instances
      @_instances ||= begin
        response = Request.get service: "as", path: "/autoscaling-api/v1/#{Configuration.project!}/scaling_group_instance/#{self.scaling_group_id}/list"
        JSON.parse(response.body)["scaling_group_instances"].map do |group|
          ASGroupInstance.new(group)
        end
      end
    end
  end
end
