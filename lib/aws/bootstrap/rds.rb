module Aws
  module Bootstrap
    class RDS
      def initialize(profile, region = 'us-east-1')
        @profile = profile
        @region = region
      end

      def create_rds_instance_with_profile
        client = Aws::RDS::Client.new(
          region: @region,
          profile: @profile
        )
        resp = client.create_db_instance({
          allocated_storage: 5,
          db_instance_class: "db.t2.micro",
          db_instance_identifier: "taka-test-rds",
          engine: "MySQL",
          master_user_password: "testtest",
          master_username: "root",
        })
      end
    end
  end
end
