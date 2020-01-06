#/bin/bash

echo -e "This command installs a specific plugin (generally a Singer.io tap or target)."
echo -e "Usage: install.sh PLUGIN_NAME [ INSTALL_SOURCE [ PLUGIN_ALIAS ] ]"
echo -e "Examples:"
echo -e "Simple install (from pip):"
echo -e "\install.sh tap-salesforce"
echo -e "Install from specific git repo or branch:"
echo -e "\install.sh tap-salesforce git+https://gitlab.com/meltano/tap-salesforce.git@master"
echo -e "Install from specific git repo and use a custom alias:"
echo -e "\install.sh tap-salesforce git+https://gitlab.com/meltano/tap-salesforce.git@master tap-m-salesforce"

PLUGIN_NAME=$1
INSTALL_SOURCE=$2
PLUGIN_ALIAS=${3-:$PLUGIN_NAME}
VENV_DIR=/venv/$PLUGIN_ALIAS

echo -e "Installing '$PLUGIN_NAME' as '$PLUGIN_ALIAS' using pip install '$INSTALL_SOURCE'..."

python3 -m venv $VENV_DIR
$VENV_DIR/bin/pip install $INSTALL_SOURCE
ln -s $VENV_DIR/bin/$PLUGIN_NAME /usr/bin/$PLUGIN_ALIAS
