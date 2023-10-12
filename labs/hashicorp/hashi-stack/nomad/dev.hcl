consul {
    address             = "consul-node1:8500"
    server_service_name = "nomad"
    client_service_name = "nomad-client"
    auto_advertise      = true
    server_auto_join    = true
    client_auto_join    = true
    # token = "${consul_acl_token}"
}
plugin "raw_exec" {
  config {
    enabled = true
  }
}
plugin "docker" {
    config {
    auth {
        #config = "/etc/docker.d/docker_config.json"
        // config = "/root/.docker/config.json"
        # Nomad will prepend "docker-credential-" to the helper value and call
        # that script name.
        # helper = "gcloud"
    }
    volumes {
        enabled = true
    }
    }
}
vault {
  enabled     = true
  address     = "vault-server1:8200"
//   namespace   = "${vault_namespace}"
  # ca_path     = "/etc/certs/ca"
  # cert_file   = "/var/certs/vault.crt"
  # key_file    = "/var/certs/vault.key"
}