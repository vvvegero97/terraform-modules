output "key_pair_name" {
  value       = aws_key_pair.key_pair.key_name
  description = "Key name of the Key Pair to use for the instance."
}
