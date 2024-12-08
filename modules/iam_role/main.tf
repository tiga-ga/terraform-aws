resource "aws_iam_role" "main" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [var.iam_assume_role_policy]
  })
  depends_on = [var.dependency_resources]
}

resource "aws_iam_policy" "custom_policy" {
  count = length(var.iam_policy_statements) > 0 ? 1 : 0

  name = var.iam_policy_name
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = var.iam_policy_statements
  })
}

resource "aws_iam_role_policy_attachment" "custom" {
  count = length(var.iam_policy_statements) > 0 ? 1 : 0

  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.custom_policy[0].arn
}

resource "aws_iam_role_policy_attachment" "managed" {
  count = length(var.managed_policy_arns)

  role       = aws_iam_role.main.name
  policy_arn = var.managed_policy_arns[count.index]
}
