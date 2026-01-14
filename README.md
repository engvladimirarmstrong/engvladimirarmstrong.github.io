# Vladimir Armstrong AI Neuron UVM Project Repository

## Quick Start Guide

### Initialize Repository Environment Variables in Linux Bash

```Bash
source init_repo_env.sh
```

### Run Hello World Directed Tests

```Bash
cd engvladimirarmstrong.github.io/source/sim/directed_tests/helloworld
./CLEAN.sh
./BUILD.sh
./RUN.sh
./WAVE.sh
```

### Run Hello World Constrained Random UVM

```Bash
cd engvladimirarmstrong.github.io/source/sim/constrained_random/helloworld
./CLEAN.sh
./BUILD.sh
./RUN.sh
./WAVE.sh
```
### Run Simple Constrained Random UVM

```Bash
cd engvladimirarmstrong.github.io/source/sim/constrained_random/simple
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

# Verilator

```Text
verilator  --V
Verilator 5.042
```

# UVM

```
1800.2-2017-1.0
```