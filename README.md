Development environment in binder, for basic C++ and Python.

Editors: emacs, nano, vim. If you want vscode, go to
https://github.com/betatim/vscode-binder 

Press this link to open an online dev environment (**WARNING**: all files will be lost if you
close the tab, download them before closing the connection)

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/iluvatar1/ProgCPP-dev/HEAD)


To test locally:
docker run -it --rm -p 8888:8888 progcpp-img jupyter-lab --NotebookApp.default_url=/lab/ --ip=0.0.0.0 --port=8888


