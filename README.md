# About me

This repository houses a template for the generation of service module repositories.
New service module should be added using Orchestration API.

This contains:

1. Sample code
2. Directory structure
3. Github actions
   - Validation flow
   - Version bumping

## Directory structure

| path          | description                       |
| ------------- | --------------------------------- |
| main.tf       | Entry point for terraform         |
| /test         | Directory contains tests          |
| /test/main.tf | Example configuration for testing |

### reference

https://www.terraform.io/docs/language/modules/develop/structure.html

## Testing configuration

It uses github actions and terraform cloud to test your module code.
In `.github/workfows/validation.yml`, it sepcifies a configuration with testing parameters and variables within the following working-directory.

```
    defaults:
      run:
        working-directory: ./test
```

### secrets

If you need to specify secrets for testing, please add them to [github secrets in the repository](https://docs.github.com/en/actions/reference/encrypted-secrets) without storing in git, and access in github actions from [contexts](https://docs.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions#contexts).
