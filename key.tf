resource "aws_key_pair" "tf-key" {
  key_name   = "tf_test"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}