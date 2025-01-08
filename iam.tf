# Create IAM policy to attach to Lambda execution role to allow Lambda to retrieve secrets from Secret Manager
resource "aws_iam_policy" "yap_secret_policy" {
    name = "yap_SecretManagerTestPolicy"

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    "secretsmanager:GetResourcePolicy",
                    "secretsmanager:GetSecretValue",
                    "secretsmanager:DescribeSecret",
                    "secretsmanager:ListSecretVersionIds",
                    "secretsmanager:GetRandomPassword"
                ]
                Effect   = "Allow"
                Resource = aws_secretsmanager_secret.yap_DB_secret.arn
      },
    ]
  })
}

# Attach policy to Lambda execution role
resource "aws_iam_policy_attachment" "yap_secret_policy_attach" {
  name = "yap_secret_policy_attach"
  roles = [aws_iam_role.lambda_exec_role.name]
  policy_arn = aws_iam_policy.yap_secret_policy.arn
}

# Create Lambda execution role
resource "aws_iam_role" "lambda_exec_role" {
 name = "yap-lambda-executionrole"
  assume_role_policy = jsonencode({
   Version = "2012-10-17",
   Statement = [
     {
       Action = "sts:AssumeRole",
       Principal = {
         Service = "lambda.amazonaws.com"
       },
       Effect = "Allow"
     }
   ]
 })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
 role       = aws_iam_role.lambda_exec_role.name
 policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}