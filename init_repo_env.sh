# Set HOME environment variables
export REPO_HOME=$(pwd)
export RTL_HOME="$REPO_HOME/source/rtl"
export SIM_HOME="$REPO_HOME/source/sim"
export TB_HOME="$REPO_HOME/source/tb"

# Set Directed Tests (DT) environment variables
export DT_SIMPLE_SIM="$SIM_HOME/directed_tests/simple"
export DT_SIMPLE_TB="$TB_HOME/directed_tests/simple"

# Activate Python virtual environment (venv)
source venv/bin/activate
