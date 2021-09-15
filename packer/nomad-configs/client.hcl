log_level = "DEBUG"
data_dir = "/opt/nomad/data"
name = "nomad-02"

client {
  enabled = true

  server_join {
    retry_join = [
      "<IP_ADDRESS OR URL>"
    ]
    retry_max = 3
    retry_interval = "15s"
  }
}

ports {
  http = 5656
}
