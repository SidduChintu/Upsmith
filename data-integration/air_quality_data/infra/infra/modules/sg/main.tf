# locals {
#   common_tags = {
#     Project = var.project_name
#     Environment = var.env
#     Terraform = "true"
#   }
# }

# Create Security Group with No Inbound and allow All Outbound Rules
# resource "aws_security_group" "step_function_state_machine_sg" {
#   name = "${var.step_function_state_machine_name_security_group}-${var.env}"
#   description = "Security Group for ${var.project_name} Step Function State Machine"
#   vpc_id = var.vpc_id

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]  
#   }

#   tags = merge(local.common_tags, {
#     Name = "${var.step_function_state_machine_name_security_group}-${var.env}"
#   })
# }

