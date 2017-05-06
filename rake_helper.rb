require "yaml"
require "erb"

def load_options
  option_yml = File.expand_path("../sample_options.yml", __FILE__)
  option_yml = ERB.new(File.read(option_yml), nil, '-').result
  YAML.load(option_yml)
end

def create_rds(options)
  o = options["rds_options"]
  cmd = ["aws-bootstrap"]
  cmd << "rds"
  cmd << "--profile" << o["profile"]
  cmd << "--region" << o["region"]
  cmd << "--name" << o["name"]
  cmd << "--allocated_storage" << o["allocated_storage"].to_s
  cmd << "--instance_type" << o["instance_type"]
  cmd << "--engine" << o["engine"]
  cmd << "--master_user" << o["master_user"]
  cmd << "--master_user_password" << o["master_user_password"]
  exit(system(*cmd) ? 0 : 1)
end
