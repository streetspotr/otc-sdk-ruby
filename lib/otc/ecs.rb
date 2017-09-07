require "hashie"

module Otc
  class ECS < Hashie::Dash
    class << self
      def query_all(name: nil)
        response = Request.get service: "ecs", path: "/v2/#{Configuration.project!}/servers/detail?name=#{name}"
        JSON.parse(response.body)["servers"].map do |server|
          keys_to_delete = server.keys - ECS::ATTRIBUTES
          keys_to_delete.each { |key| server.delete(key) }

          ECS.new(server)
        end
      end

      def query_one(name: nil)
        query_all(name: name).first
      end
    end

    ATTRIBUTES = [
      "name", "id", "status", "created", "updated", "flavor", "image", "tenant_id", "key_name", 
      "user_id", "metadata", "hostId", "addresses", "security_groups", "tags", "links", "progress"
    ]

    ATTRIBUTES.each { |prop| property prop }

    def public_ip
      @_public_ip ||= begin
        private_addresses = self.addresses.values.flatten.map { |val| val["addr"] }

        eip = EIP.query_all.select { |ip| private_addresses.include?(ip.private_ip_address) }.first
        if eip
          eip.public_ip_address
        end
      end
    end
  end
end
