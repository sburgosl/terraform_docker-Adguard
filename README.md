# terraform_docker-Adguard
Terraform Module for Docker AdguardHome Container

## Setup
To create an Adguard container:

```
$ terraform init
$ terraform apply
```
Go to http://127.0.0.1:3000 to config AdguarHome.

## Module
For use this on your project, add the following lines to your terraform file:

```
module "adguard" {
    source = "git@github.com:sburgosl/terraform_docker-Adguard.git"
}
```

## Variables
#### Adguard Version
To select AdguardHome image version change the variable `adguard_version` with desired image tag.
For example:
```
variable "adguard_version" {
  type        = string
  default     = "v0.104.0"
  description = "Docker Image Tag"
}
```

#### First Config
If there is not configuration, Adguard exposes port tcp/3000 for first config.
When configuration exists, the port is not required. You can disable it by changin the variable `fist_config` to **false**. 


#### HTTPS
To use HTTPS change the variable `use_https` to **true**.


#### DHCP Server
To use Adguard as DHCP server, set the variable `use_dhcp` to **true**, to enable the DHCP ports.


#### Adguard Config Path
Change the variables `adguard_workdir` and `adguard_confdir` with the desired host path.


#### Change Web UI Port (HTTP)
You can change the http internal, and external, port where Adguard enables the web service.
`int_http_ui_port`for container port. **This port must be the same as the configured in Adguard**.
`ext_http_ui_port`for host port.


#### Traefik
To use Traefik as reverse proxy of Adguard, change the variable `use_traefik` to **true**.
When using this option, the web ports will not be exposed outside the container.
If `use_https` is set to **true**, traefik will use websecure entrypoint and redirect traffic to tcp/443 container port.

See: https://github.com/sburgosl/terraform_docker-Traefik

#### Domain Name
Set your domain in the variable `domain_name` to use in Host router Rule"