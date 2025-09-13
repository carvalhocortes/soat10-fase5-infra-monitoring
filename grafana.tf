resource "time_sleep" "wait_for_grafana" {
  depends_on = [aws_instance.grafana]

  create_duration = "120s"
}
