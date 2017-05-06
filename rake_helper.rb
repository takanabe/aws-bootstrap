require "yaml"
require "erb"
require 'json'

def load_options
  option_yml = File.expand_path("../sample_options.yml", __FILE__)
  yaml = ERB.new(File.read(option_yml), nil, '-').result
  YAML.load(yaml)
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
  cmd << "--availability_zone" << o["availability_zone"]
  cmd << "--publicly_accessible" << o["publicly_accessible"].to_s
  cmd << "--multi_az" << o["multi_az"].to_s
  cmd << "--preferred_maintenance_window" << o["preferred_maintenance_window"]
  cmd << "--db_parameter_group_name" << o["db_parameter_group_name"]
  cmd << "--db_name" << o["db_name"]
  cmd << "--backup_retention_period" << o["backup_retention_period"].to_s
  cmd << "--preferred_backup_window" << o["preferred_backup_window"]
  cmd << "--tags" << JSON.generate(o["tags"])
  # cmd << "--db_security_groups" << JSON.generate(o["db_security_groups"])
  cmd << "--db_subnet_group_name" << o["db_subnet_group_name"]
  cmd << "--engine_version" << o["engine_version"]
  cmd << "--auto_minor_version_upgrade" << o["auto_minor_version_upgrade"].to_s
  cmd << "--license_model" << o["license_model"]
  cmd << "--option_group_name" << o["option_group_name"]
  cmd << "--storage_type" << o["storage_type"]
  # cmd << "--vpc_security_group_ids" << JSON.generate(o["vpc_security_group_ids"])
  exit(system(*cmd) ? 0 : 1)
end
