module Aws
  module Bootstrap
    class RDS
      def initialize(options)
        @options = options.compact
      end

      def create_rds_instance_with_profile
        client = Aws::RDS::Client.new(
          profile: @options[:profile],
          region: @options[:region],
        )

        @options[:tags] = JSON.parse(@options[:tags])
        @options[:vpc_security_group_ids] = JSON.parse(@options[:vpc_security_group_ids])
        @options.compact!
        resp = client.create_db_instance(
          @options.except(
            :command,
            :profile,
            :region,
          )
        )
      end
    end
  end
end
