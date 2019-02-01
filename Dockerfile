FROM python:3

LABEL "com.github.actions.name"="Publish Python Package"
LABEL "com.github.actions.description"="Package and publish Python modules."
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="yellow"

LABEL "repository"="http://github.com/mariamrf/py-package-publish-action"
LABEL "maintainer"="Mariam Maarouf <mrf.mariam@gmail.com>"

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
