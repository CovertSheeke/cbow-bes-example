#!/bin/bash

set -e  # Exit on error

echo "=== STEP 1: Install Miniconda ==="

# Create directory for Miniconda
mkdir -p ~/miniconda3

# Download installer
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh

# Install silently (-b), update if exists (-u), to prefix path
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3

# Clean up installer
rm ~/miniconda3/miniconda.sh

# Activate conda base
source ~/miniconda3/bin/activate

# Initialise conda for all shells
conda init --all

echo "Miniconda installed and initialised."

echo
echo "=== STEP 2: Check RunPod Volume ==="

# List mounted volumes
echo "--- Mounted Filesystems ---"
df -h | grep "^/"

# Check common mount path
VOLUME_PATH="~/workspace"
if [ -d "$VOLUME_PATH" ]; then
    echo "Found volume mount at $VOLUME_PATH"

    # Try writing a file
    TEST_FILE="$VOLUME_PATH/testfile.txt"
    echo "Writing test file..."
    echo "RunPod volume write test at $(date)" > "$TEST_FILE"

    # Read back the file
    echo "Reading test file:"
    cat "$TEST_FILE"

    echo "Cleaning up test file..."
    rm "$TEST_FILE"

    echo "RunPod volume appears connected and writable."
else
    echo "Warning: Expected volume path $VOLUME_PATH does not exist."
    echo "Check your RunPod volume mount settings."
fi
echo
echo "=== STEP 3: Git Push Troubleshooting ==="

echo "If you see:"
echo "  error: src refspec main does not match any"
echo "  error: failed to push some refs to 'https://github.com/CovertSheeke/cbow-bes-example.git'"
echo
echo "This usually means you have not committed anything to the 'main' branch yet."
echo "Try the following steps:"

echo "1. Check your current branch:"
echo "   git branch"

echo "2. If you are not on 'main', create and switch to it:"
echo "   git checkout -b main"

echo "3. Add your files:"
echo "   git add ."

echo "4. Commit your changes:"
echo "   git commit -m 'Initial commit'"

echo "5. Push to GitHub:"
echo "   git push -u origin main"

echo
echo "If you still have issues, check your remote URL with:"
echo "   git remote -v"