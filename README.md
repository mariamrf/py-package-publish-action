# Publish Python Package
A Github Action to build and publish your Python package to PyPI or any other repository. Supports any Python version you'll give it (that is also supported by [pyenv](https://github.com/pyenv/pyenv)).

## Use
### Pre-requisites
In order for the Action to have access to the code, you must use the `actions/checkout@master` job before it. See the example below.

### Environment Variables/Secrets
- Login credentials for the package repo (as specified by [twine](https://twine.readthedocs.io/en/latest/#environment-variables)). So, for example:
    - `TWINE_USERNAME`=`scott`
    - `TWINE_PASSWORD`=`tiger`
    etc.  
This would also be where you'd set `TWINE_REPOSITORY_URL` if publishing to something other than PyPI.

### Inputs
- `python_version`: a Python version that is supported by [pyenv](https://github.com/pyenv/pyenv). For example: `3.7.0`.
- `subdir` (optional): if your `setup.py` (and therefore, your entire package) is in a subdirectory of your repo, put the path to it here. This will just change the working directory to the `SUBDIR` before running the rest of the script.

### Example workflow
```yaml
name: publish

on:
  push:
    branches:
      - master

jobs:
  build:

    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@master
    - name: Publish Python Package
      uses: mariamrf/py-package-publish-action@v2
      with:
        python_version: '3.6.0'
      env:
        TWINE_PASSWORD: ${{ secrets.TWINE_PASSWORD }}
        TWINE_USERNAME: ${{ secrets.TWINE_USERNAME }}

```
