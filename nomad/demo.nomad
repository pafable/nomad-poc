job "demo" {
    datacenters = ["dc1"]
    type = "service"

    group "blog" {
        count = 1

        network {
            mode = "none"
            port "ghost" {
                static = 80
                to = 2368
            }
        }

        task "ghost" {
            driver = "docker"
            kill_timeout = "30s"

            config {
                image = "ghost:latest"
                ports = ["ghost"]
            }

            resources {
                cpu = 100
                memory = 256
            }
        }
    }
}