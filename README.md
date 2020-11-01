# terraform_docker-Adguard
Docker AdguardHome Terraform Module

## Setup
To create an Adguard container:

```
$ terraform init
$ terraform apply
```
Go to http://127.0.0.1:3000 to config AdguarHome.

## Module
For use this on your project, add to your terraform file:

```
module "adguard" {
    source = "git@github.com:sburgosl/terraform_docker-Adguard.git"
}
```

## Variables
#### Adguard Version
To select AdguardHome image version change the variable `adguard_version` with image tag.
For example:
```
variable "adguard_version" {
  type        = string
  default     = "v0.104.0"
  description = "Docker Image Tag"
}
```

#### HTTPS
To use HTTPS change the variable `use_https` to true.

#### Traefik
To use Traefik as reverse proxy, change the variable `use_traefik` to true.
When using this option, the web ports will not be exposed outside the container.
