# terraform blocks

block-type block-label block-labe{  #block
    identifire = expression  #argument
}

blokc types-> settings, provider, resource, data, input, local, output, module

terraform works with diff clouds using providers(1500) plugin architecture(can be seen in terraform registry->(official, verified, community))


terraform --version -> terraform version + proiders installed
terraform providers -> providers required

you can set env variables like -> export ACCESS_KEY="Example" (can be given in provider block(not recomended))
best=> a credential file, shared_credential_file="..."


variables->
unique, use variable.tf file, provided values take precedence order

precedence: command line > .auto.tfvars > terraform.tfvars > env-vars > variables-default

variable "--name--"{
    ...
}


locals->
reduce repetitive reference, locals reffered using local

locals{
    l_var="--var--"
}

data block->
can be multiple, retrive data from apis and other tf workspaces(connect them), use tf to pull data about pre-created aws resources

data "data-type" "data-local-name"{  
    identifire = expression
}

to refer read about the data-source from the service->data-source in the terraform registry


configurations block->
created in terraform.tf file, can be used to set terraform/providers versions

terraform{

}


modules->
combine different resources to make them reusable(use variables), called by root/parent module(contains child module), can be from registry or local, each child module named by its function and contains main.tf, variables.tf and outputs.tf


output->
export structred data using terraform, op can be input for another workspace


once init with providers-> creates a dependency lock(terraform.lock.hcl)-> stores where the provider was installed from


**provisioners**

model actions on local/remote machines
- local exec
- remote exec: communicates with remote machine using ssh

demo: using this we can directly deployed a website on an was instance