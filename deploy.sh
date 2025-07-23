#!/bin/bash

# -------------------------------
# CONFIGURATION
# -------------------------------
EC2_USER=ubuntu                         # or ec2-user for Amazon Linux
EC2_HOST=13.234.XXX.XXX                 # Replace with your EC2 public IP
PEM_KEY_PATH=./ec2-key.pem              # Path to your private key file
APP_DIR=/home/ubuntu/myapp              # Remote directory on EC2
LOCAL_APP_DIR=./                        # Local app directory

# -------------------------------
# DEPLOYMENT STARTS
# -------------------------------
echo "🔄 Starting deployment to EC2..."

# Step 1: Upload files using rsync
echo "📤 Syncing files to EC2..."
rsync -avz -e "ssh -i $PEM_KEY_PATH -o StrictHostKeyChecking=no" \
    $LOCAL_APP_DIR $EC2_USER@$EC2_HOST:$APP_DIR

# Step 2: Connect via SSH and restart the app
echo "🚀 Running app on EC2..."
ssh -i $PEM_KEY_PATH -o StrictHostKeyChecking=no $EC2_USER@$EC2_HOST << EOF
  cd $APP_DIR

  # Optional: Pull latest code from git if required
  # git pull origin main

  # Install dependencies (for Python)
  if [ -f "requirements.txt" ]; then
    pip3 install -r requirements.txt
  fi

  # Start or restart your app
  # Replace this with your own command
  pkill -f app.py || true
  nohup python3 app.py > output.log 2>&1 &
EOF

echo "Deployment complete!"
