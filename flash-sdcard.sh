#!/bin/bash

# Check if the correct number of arguments is provided
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <path_to_image> <device>"
    echo "Example: $0 sdcard.img /dev/sdX"
    echo "lsblk can be used to determine <device>"
    exit 1
fi

IMAGE=$1
DEVICE=$2

# Check if the image file exists
if [[ ! -f "$IMAGE" ]]; then
    echo "Error: Image file $IMAGE not found."
    exit 1
fi

# Check if the device exists
if [[ ! -b "$DEVICE" ]]; then
    echo "Error: Device $DEVICE not found."
    echo "Ensure the correct device path, like /dev/sdX or /dev/mmcblk0."
    exit 1
fi

# Warn the user about the potential data loss
echo "WARNING: This will erase all data on $DEVICE!"
read -p "Are you sure you want to proceed? (yes/no): " CONFIRM
if [[ "$CONFIRM" != "yes" ]]; then
    echo "Operation canceled."
    exit 0
fi

# Unmount any mounted partitions on the device
echo "Unmounting any mounted partitions on $DEVICE..."
sudo umount ${DEVICE}?* 2>/dev/null

# Flash the image to the SD card using dd
echo "Flashing $IMAGE to $DEVICE..."
sudo dd if="$IMAGE" of="$DEVICE" bs=4M status=progress conv=fsync

# Sync and safely eject
echo "Syncing data to ensure it's fully written to the device..."
sync
echo "Flash complete. You can now safely remove the SD card."
