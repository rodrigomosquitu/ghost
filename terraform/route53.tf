data "aws_route53_zone" "selected" {
  name         = "rodmosq.link."
  private_zone = false
}

resource "aws_route53_record" "tfer--Z043236731QLLZZ8SU1HU_rodmosq-002E-link-002E-_A_" {
  alias {
    evaluate_target_health = "false"
    name                   = aws_lb.ghost_alb.dns_name
    zone_id                = "Z35SXDOTRQ7X7K"
  }

  name    = "rodmosq.link"
  type    = "A"
  zone_id = data.aws_route53_zone.selected.zone_id
}

resource "aws_route53_record" "tfer--Z043236731QLLZZ8SU1HU_www-002E-rodmosq-002E-link-002E-_A_" {
  alias {
    evaluate_target_health = "false"
    name                   = aws_lb.ghost_alb.dns_name
    zone_id                = "Z35SXDOTRQ7X7K"
  }

  name    = "www.rodmosq.link"
  type    = "A"
  zone_id = data.aws_route53_zone.selected.zone_id
}
