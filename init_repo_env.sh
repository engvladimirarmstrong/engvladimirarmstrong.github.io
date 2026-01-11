# Set HOME environment variables
export REPO_HOME=$(pwd)
export RTL_HOME="$REPO_HOME/source/rtl"
export TB_HOME="$REPO_HOME/source/tb"

# Set Directed Tests (DT) environment variables
export DT_SIMPLE_TB="$TB_HOME/directed_tests/simple"

# Set Constrained Random (CR) environment variables
export CR_SIMPLE_TB="$TB_HOME/constrained_random/simple"

# Activate Python virtual environment (venv)
source venv/bin/activate
