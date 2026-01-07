IAC?
instead of looging to ui, codify manual cloud actions. Tools- Terraform(multicloud), cloudFormations, azure resource manager etc.

Why/Benefits?
version control, automation

terraform init -> initialize working directory. No channge to state+config files.
terraform validate -> validate configs syntacticaly and consistent. Correctness of arrtibute names and types. Not perfect.
terraform plan -> Execution plan. Compares state of the resources of public cloud to our local state file.
terraform apply -> Executes actions presented in plan.
terraform destroy -> Destroys resources.

save plans: terraform plan -out myplan
apply previously saved plan: terraform apply myplan


if require multiple of same setup in diff server, use diff directories with same code or workkspaces.

terraform providers: official, partner, community