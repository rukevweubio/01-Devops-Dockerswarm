#!/bin/bash

IMAGE_NAME="gke-devops-tools"

# 1. Build the image
echo "Building DevOps container image..."
docker build -t $IMAGE_NAME -f Dockerfile .  

# 2. Run the container and go inside
# -v $(pwd):/workspace  -> Mounts your code
# -it                   -> Interactive terminal
# --rm                  -> Deletes container when you exit
echo "Entering container... You are now in /workspace"
docker run -it --rm \
    -v $(pwd):/workspace \
    $IMAGE_NAME /bin/bash