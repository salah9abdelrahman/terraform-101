output "alb_dns_name" {
  value       = module.webserver.alb_dns_name
  description = "DNS of web server LB"
}
