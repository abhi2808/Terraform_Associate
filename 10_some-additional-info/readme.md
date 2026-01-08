## non-cloud providers
there are several like random(random_password, random_integer)

keepers block:
keepers={
    v=timestamp()
}

The keepers block tells Terraform when a resource must be recreated based on changes in specific values. If any value inside keepers changes → Terraform destroys and recreates that resource.

## auto complete
terraform -install-autocomplete(works with powershell)


## provider aliasing
can specify the alias in provider block, then in the resource block specify which provider(named by alias) to use