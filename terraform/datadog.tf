resource "datadog_monitor" "HTTP_Check_2" {
  include_tags = false
  no_data_timeframe = 2
  notify_no_data = true
  require_full_window = false
  monitor_thresholds {
    critical = 1
    ok = 1
    warning = 1
  }
  name = "HTTP Check 2"
  type = "service check"
  query = ""http.can_connect".over("instance:redmine_service_check").exclude("env:production").by("*").last(2).count_by_status()"
  message = "HTTP Check failed"
}