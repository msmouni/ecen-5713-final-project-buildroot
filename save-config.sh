#!/bin/bash
#Script to save the modified configuration as modified_qemu_aarch64_virt_defconfig and linux kernel configuration.
#Author: Siddhant Jajoo.

cd `dirname $0`
source shared.sh
mkdir -p base_external/configs/

# Save Buildroot defconfig
make -C buildroot savedefconfig BR2_DEFCONFIG=${AESD_MODIFIED_DEFCONFIG_REL_BUILDROOT}

# Save Linux defconfig if enabled
if [ -e buildroot/.config ] && ls buildroot/output/build/linux-*/.config 1>/dev/null 2>&1; then
    grep -q "BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE" buildroot/.config
    if [ $? -eq 0 ]; then
        echo "Saving Linux defconfig"
        make -C buildroot linux-update-defconfig \
            BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE=$AESD_LINUX_CONFIG_REL_BUILDROOT
    fi
fi
