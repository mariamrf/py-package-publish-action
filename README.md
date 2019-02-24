# Publish Python Package
A Github Action to publish your Python package to PyPI or any other repository. Supports any Python version you'll give it (that is also supported by [pyenv](https://github.com/pyenv/pyenv)).

## Use
Doesn't take any arguments.

### Environment Variables/Secrets
- Login credentials for the package repo (as specified by [twine](https://twine.readthedocs.io/en/latest/#environment-variables)). So, for example:
    - `TWINE_USERNAME`=`scott`
    - `TWINE_PASSWORD`=`tiger`
    etc.  
This would also be where you'd set `TWINE_REPOSITORY_URL` if publishing to something other than PyPI.
- `PYTHON_VERSION`: a Python version that is supported by [pyenv](https://github.com/pyenv/pyenv). For example: `3.7.0`.
- `SUBDIR` (optional): if your `setup.py` (and therefore, your entire package) is in a subdirectory of your repo, put the path to it here. This will just change the working directory to the `SUBDIR` before running the rest of the script.

### Example workflow
```hcl
workflow "Publish" {
  on = "push"
  resolves = ["publish-to-pypi"]
}

action "publish-to-pypi" {
  needs = "Master"
  uses = "mariamrf/py-package-publish-action@master"
  secrets = ["TWINE_PASSWORD", "TWINE_USERNAME"]
  env = {
    BRANCH = "master"
    PYTHON_VERSION = "3.6.0"
  }
}

# Filter for master branch
action "Master" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}
```
