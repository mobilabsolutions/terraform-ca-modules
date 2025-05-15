# Introduction 
This repository contains terraform modules for Azure, that helps create infrastructure according to Mobilab's standards. 

# Using modules
The recommended way of using the modules is by git reference.
As you can see in the example below:

```terraform
module "project" {
    source              = "git::https://MobiLab-Solutions-GmbH@dev.azure.com/MobiLab-Solutions-GmbH/Terraform-test/_git/TF-modules//Mobilabs-project?ref=v0.12.1"
    ...
    ...
}
```

Please note that it is strongly recommended using a specific version of module (git tag).
In the example above it is achieved by the `?ref=v0.12.1` part of source.
Details on the versions can be found in the [changelog](CHANGELOG.md).

# Writing modules
The repository has policies configured so that all changes should be implemented in new (feature) branches.
Master branch is only updated by pull requests. 
Changelog should be updated before creating the pull request and tag needs to be assigned right after PR completion.

Make sure to include implementation of your module into test infrastructure (CI/CD section fo the doc).
Also make sure to include a `README.md` file into module directory with detailed description and examples of module usage.
