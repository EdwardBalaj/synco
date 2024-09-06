#!/bin/bash

# 1. create service to run in background
# 2. use a configuration file
# 3. be able to call a customizer that edits the file

# Step 1: Make SyncO folder
echo "Making synco folder"
mkdir /opt/synco/bin

# Step 2: Move SyncO
echo "Moving synco folder"
cp synco.sh /opt/synco/bin/synco.sh

# Step 3: Make SyncO runnable
echo "Making synco runnable"
chmod +X /opt/synco/bin/synco.sh

# Step 1: Make SyncO configurations folder
echo "Making synco configurations folder"
mkdir /etc/opt/synco

# Step 1: Make SyncO configuration
echo "Making synco configuration"
touch /etc/opt/synco/synco.conf

# Variables
SERVICE_NAME="synco"
SERVICE_FILE="/etc/systemd/system/$SERVICE_NAME.service"
SCRIPT_PATH="sudo -s bash /opt/synco/bin/synco.sh"

# Step 1: Create the systemd service file
echo "Creating the systemd service file at $SERVICE_FILE"
cat <<EOF > $SERVICE_FILE
[Unit]
Description=Easy to setup, highly customizable, fast files sync application
After=network.target

[Service]
ExecStart=$SCRIPT_PATH
WorkingDirectory=/opt/synco/bin
User=root
Group=root

[Install]
WantedBy=multi-user.target
EOF

# Step 2: Reload systemd daemon to recognize the new service
echo "Reloading systemd daemon"
systemctl daemon-reload

# Step 3: Enable the service to start on boot
echo "Enabling $SERVICE_NAME to start on boot"
systemctl enable $SERVICE_NAME

# Step 4: Start the service
echo "Starting $SERVICE_NAME"
systemctl start $SERVICE_NAME

# Step 5: Check service status
systemctl status $SERVICE_NAME