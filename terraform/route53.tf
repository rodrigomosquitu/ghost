data "aws_route53_zone" "selected" {
  name         = var.r53_zone_name
  private_zone = false
}

resource "aws_route53_record" "tfer--Z043236731QLLZZ8SU1HU_rodmosq-002E-link-002E-_A_" {
  alias {
    evaluate_target_health = "false"
    name                   = aws_lb.ghost_alb.dns_name
    zone_id                = var.r53_zone_id
  }

  name    = "rodmosq.link"
  type    = "A"
  zone_id = data.aws_route53_zone.selected.zone_id
}

resource "aws_route53_record" "tfer--Z043236731QLLZZ8SU1HU_www-002E-rodmosq-002E-link-002E-_A_" {
  alias {
    evaluate_target_health = "false"
    name                   = aws_lb.ghost_alb.dns_name
    zone_id                = var.r53_zone_id
  }

  name    = "www.rodmosq.link"
  type    = "A"
  zone_id = data.aws_route53_zone.selected.zone_id
}
