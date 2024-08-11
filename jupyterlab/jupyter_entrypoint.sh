#!/bin/bash
set -e

# Function to generate config without prompts
generate_config_without_prompt() {
    yes | jupyter server --generate-config
}

# Generate a config file if it doesn't exist, without prompts
generate_config_without_prompt

# Set up the password
if [ ! -z "$JUPYTER_PASSWORD" ]; then
    # Hash the password and add it to the config
    HASHED_PASSWORD=$(python3 -c "from jupyter_server.auth import passwd; print(passwd('$JUPYTER_PASSWORD'))")
    echo "c.ServerApp.password = '$HASHED_PASSWORD'" >> /root/.jupyter/jupyter_server_config.py
    echo "Password protection enabled"
else
    echo "WARNING: No password set, JupyterLab will be accessible without authentication"
fi

# Additional configurations
echo "c.ServerApp.ip = '0.0.0.0'" >> /root/.jupyter/jupyter_server_config.py
echo "c.ServerApp.allow_root = True" >> /root/.jupyter/jupyter_server_config.py
echo "c.ServerApp.open_browser = False" >> /root/.jupyter/jupyter_server_config.py
echo "c.ServerApp.root_dir = '/opt/jupyter/work'" >> /root/.jupyter/jupyter_server_config.py

# Start JupyterLab
exec jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root