job "demo" {
    datacenters = ["dc1"]
    type = "service"

    group "blog" {
        count = 1

        network {
            port "http" {
                to = 2368
                static = 2368
            }
        }

        task "ghost" {
            driver = "docker"

            config {
                image = "ghost:latest"
                ports = ["http"]
            }

            resources {
                cpu = 100
                memory = 256
            }
        }
    }
}