module Aws
  module Bootstrap
    class RDS
      def initialize(profile = nil,region = 'us-east-1')
        @profile = profile
        @region = region
      end

      def create_rds_instance
        client = Aws::RDS::Client.new(
          access_key_id: ENV['AWS_ACCESS_KEY_ID'],
          secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
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
