FROM python:3

LABEL "com.github.actions.name"="Publish to PyPI"
LABEL "com.github.actions.description"="Package and publish Python modules."
LABEL "com.github.actions.icon"="upload"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="http://github.com/mariamrf/pypi-publish-action"
LABEL "maintainer"="Mariam Maarouf <mrf.mariam@gmail.com>"

ENV PYTHON_VERSION 3.7.0
RUN apt-get update
RUN apt-get install -y jq

ENV PYENV_ROOT /root/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

RUN pyenv install $PYTHON_VERSION
RUN pyenv global $PYTHON_VERSION
RUN pip install --upgrade setuptools wheel twine

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
