# hongkong-parking-vacancy-api

hongkong-parking-vacancy-api

documentation: <https://documenter.getpostman.com/view/3827865/2sA3Qzb8us>

api url: <https://pkcdw9yya6.execute-api.ap-southeast-1.amazonaws.com/prod/get_parking_vacancy>

## Requirement

- install terraform

## Testing and run

```zsh
// prepare working directory
$ terraform init

// format your configuration in the standard style
$ terraform fmt

// check the configuration is valid
$ terraform validate

// show changes of the current configuration
$ terraform plan

// create or update infrastructure
$ terraform apply

// destroy previously created infrastructure
$ terraform destroy
```

```zsh
// create new terraform workspace
$ terraform workspace new <workspace-name>

// select terraform workspace
$ terraform workspace select <workspace-name>

// list terraform workspace
$ terraform workspace list

// delete terraform workspace
$ terraform workspace delete
```
