resource "aws_key_pair" "tf-key" {
  key_name   = "tf_test"
  public_key = file(var.path_public_key)
}