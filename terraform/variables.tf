variable "github_repo" {
  description = "Nome do repositório do GitHub"
  type        = string
}

variable "lambda_handler" {
  description = "O handler da Lambda"
  type        = string
  default     = "index.handler"
}

variable "lambda_runtime" {
  description = "O runtime da Lambda"
  type        = string
  default     = "python3.12"
}

variable "subnet_ids" {
  description = "Lista de IDs das sub-redes para a Lambda"
  type        = list(string)
  default = [ "subnet-01851434bb18a01db", "subnet-0c28b70a1e7ddccc4" ]
}

variable "security_group_ids" {
  description = "Lista de IDs dos grupos de segurança para a Lambda"
  type        = list(string)
  default     = [ "sg-059ded679fe2a3a99" ]
}

variable "lambda_layers" {
  description = "Lista de ARNs das camadas Lambda"
  type        = list(string)
  default     = [
    "arn:aws:lambda:us-east-1:454362774081:layer:Dependencies-python:2",
    "arn:aws:lambda:us-east-1:454362774081:layer:auth:4",
    "arn:aws:lambda:us-east-1:454362774081:layer:dbconn:1"  
  ]
}


# -var="github_repo=$repo_name"