// Using data sources to access Terraform (AWS) secrets

data "aws_secretsmanager_secret" "mydb_secret" {
  arn = "arn:aws:secretsmanager:eu-central-1:532199187081:secret:pg_db-dKuRrd"
}

data "aws_secretsmanager_secret_version" "mydb_secret_version" {
  secret_id = data.aws_secretsmanager_secret.mydb_secret.id
}

resource "aws_db_instance" "my_db" {
  allocated_storage    = 20
  storage_type        = "gp2"
  engine              = "postgres"
  engine_version      = "12"
  instance_class      = "db.t2.micro"
  username            = jsondecode(data.aws_secretsmanager_secret_version.mydb_secret_version.secret_string).username
  password            = jsondecode(data.aws_secretsmanager_secret_version.mydb_secret_version.secret_string).password
  skip_final_snapshot = true


  tags = {
    Name = "ExampleDB"
  }

  tags_all = {
    Environment = "Development"
  }
}

output "dbusername" {
  value = jsondecode(data.aws_secretsmanager_secret_version.mydb_secret_version.secret_string).username
  sensitive = true
}

output "dbpassword" {
  value = jsondecode(data.aws_secretsmanager_secret_version.mydb_secret_version.secret_string).password
  sensitive = true
}

