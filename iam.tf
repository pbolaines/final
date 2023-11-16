resource "aws_iam_policy" "ariuna_policy" {
  name        = "${var.environment}_s3_access_policy"
  path        = "/"
  description = "ariuna 2023 test policy"
 
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": [
          "*"
      ]
    }
  ]
}
EOF
}
 
resource "aws_iam_role" "ariuna_role" {
  name = "${var.environment}_s3_test_role"
 
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
  tags = {
    Environment = var.environment
  }
}
 
resource "aws_iam_policy_attachment" "ariuna_attach" {
  name       = "${var.environment}-ariuna-test-attachment"
  roles      = [aws_iam_role.ariuna_role.name]
  policy_arn = aws_iam_policy.ariuna_policy.arn
}
 
resource "aws_iam_instance_profile" "ariuna_profile" {
  name = "${var.environment}-ariuna_2023_ec2_profile"
  role = aws_iam_role.ariuna_role.name
}
