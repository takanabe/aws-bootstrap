module Aws
  module Bootstrap
    class RDS
      def initialize(options)
        @options = options
      end

      def create_rds_instance_with_profile
        # profile: 'dev',
        # region: 'us-east-1',
        client = Aws::RDS::Client.new(
          profile: @options[:profile],
          region: @options[:region],
        )
        # allocated_storage: 5,
        # db_instance_class: "db.t2.micro",
        # db_instance_identifier: "test-rds",
        # engine: "MySQL",
        # master_user_password: "testtest",
        # master_username: "root",
        resp = client.create_db_instance({
          allocated_storage: @options[:allocated_storage],
          db_instance_class: @options[:instance_type],
          db_instance_identifier: @options[:name],
          engine: @options[:engine],
          master_user_password: @options[:master_user_password],
          master_username: @options[:master_user],
        })
      end
    end
  end
end
