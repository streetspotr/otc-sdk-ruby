module Otc
  class Configuration
    class Missing < RuntimeError; end

    class << self
      attr_accessor :project, :username, :password, :region, :domainname

      def configure
        yield self
      end

      def reset
        @project = nil
        @username = nil
        @password = nil
        @region = nil
        @domainname = nil
      end

      def method_missing(m, *args, &block)
        m_as_string = m.to_s

        if m_as_string.end_with?("!")
          method = m_as_string.split("!").first.to_sym

          if self.respond_to?(method)
            send(method).tap do |result|
              raise Missing, "missing configuration #{method}" if result.nil?
            end
          else
            super
          end
        else
          super
        end
      end
    end
  end
end
