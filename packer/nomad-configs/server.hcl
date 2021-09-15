log_level = "DEBUG"
data_dir = "/opt/nomad/data"
bind_addr = "0.0.0.0"
name = "nomad-01-110"

server {
  enabled = true
  bootstrap_expect = 1
}