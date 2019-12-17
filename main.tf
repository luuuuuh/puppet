provider "docker"{
   host = "tcp://127.0.0.1:2375/"
}
resource "docker_network" "private_network" {
  name = "my_network"
}
resource "docker_container" "server-puppet" {
  image = "${docker_image.server-puppet.latest}"
  must_run = true
  networks = [ "${docker_network.private_network.name}" ]
  name = "server-puppet"
  restart = "on-failure"
  hostname = "server-puppet"
}

resource "docker_container" "ubuntu" {
  image = "${docker_image.ubuntu.latest}"
  must_run = true
  networks = [ "${docker_network.private_network.name}" ]
  command = ["/bin/bash"]
  name = "puppet-client"
  #restart = "on-failure"
  hostname = "puppet-client"
}

resource "docker_image" "server-puppet" {
    name = "puppet/puppetserver:latest"
  
}
resource "docker_image" "ubuntu" {
  name = "ubuntu:latest"
}



