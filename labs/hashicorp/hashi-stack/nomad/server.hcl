data_dir = "/nomad/data/"
bind_addr = "0.0.0.0"
datacenter = "dc1"
server {
    enabled = true
    bootstrap_expect = 1
    server_join {
        retry_join = ["nomad-server1","nomad-server2","nomad-server3"]
    }
}
advertise {
    http = "{{GetInterfaceIP \"eth1\"}}"
    rpc  = "{{GetInterfaceIP \"eth1\"}}"
    serf = "{{GetInterfaceIP \"eth1\"}}"
}
consul {
    address             = "consul-node1:8500"
    server_service_name = "nomad"
    client_service_name = "nomad-client"
    checks_use_advertise = true
    auto_advertise      = true
    server_auto_join    = true
    client_auto_join    = true
    # token = "${consul_acl_token}"
}
acl {
    enabled = false
}
client {
    enabled = false
}
vault {
    enabled = true
    address = "http://vault-server1:8200"
    token = "${vault_token}"
}