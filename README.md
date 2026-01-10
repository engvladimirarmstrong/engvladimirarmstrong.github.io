# Vladimir Armstrong AI Neuron UVM Project Repository

## Quick Start Guide

### Initialize Repository Environment Variables in Linux Bash

```Bash
source init_repo_env.sh
```

### Run Simple Directed Tests

```Bash
cd engvladimirarmstrong.github.io/source/sim/directed_tests/simple
./CLEAN.sh
./BUILD.sh
./RUN.sh
./WAVE.sh
```

## Environment From Scratch

Setting an environment from scratch involves choosing your Linux OS (Ubuntu), installing necessary software:

```Text
# venv setup from scratch
python3 -m venv venv

# Activate venv
source venv/bin/activate

# Add-ons
pip install sphinx-rtd-theme
pip install sphinx-rtd-size
pip install sphinx-design
pip install sphinxcontrib-plantuml
pip install sphinx-copybutton
```