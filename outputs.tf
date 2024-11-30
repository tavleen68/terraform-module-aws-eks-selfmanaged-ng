output "arn" {
  value = nonsensitive(local.kms_key_arn)
}
