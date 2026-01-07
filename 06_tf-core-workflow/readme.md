write(+init)->plan->apply

can also "terraform plan -destroy" before destroying

for any local/remote backend or new providers you need to init, to copy config locally. To get latest modules/providers use "terraform init -upgrade"

you can use, backend block in the terraform block to store the state files in diff locations

validate => only syntax only, wont check of references/paths are correct. Can do terraform validate -json to get op in format

plan => gets you the changes that would be made after applying

- "+" : created
- "-" : destroyed
- "~" : updated in-place
- "-/+" : destroyed and rectreated

terraform plan -refresh-only : to refresh state of all resources managed by tf


apply => apply chnages,
can terraform apply -auto-approve


destroy => destroy without technical debt