resource "aws_iam_policy" "pb_policy" {
  name        = "${var.environment}_pb_s3_access_policy"
  path        = "/"
  description = "pb 2023 test policy"
 
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
 
resource "aws_iam_role" "pb_role" {
  name = "${var.environment}_pb_s3_test_role"
 
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
 
resource "aws_iam_policy_attachment" "pb_attach" {
  name       = "${var.environment}-pb-test-attachment"
  roles      = [aws_iam_role.ariuna_role.name]
  policy_arn = aws_iam_policy.pb_policy.arn
}
 
resource "aws_iam_instance_profile" "pb_profile" {
  name = "${var.environment}-pb_2023_ec2_profile"
  role = aws_iam_role.pb_role.name
}
