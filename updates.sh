#!/bin/bash

if [ ! -d ".repo" ]; then
    echo -e "No .repo directory found.  Is this an Android build tree?"
    exit 1
fi

android="${PWD}"

# Add local cherries if they exist
if [ -f ${android}/updates-local.sh ]; then
    source ${android}/updates-local.sh
fi

# Use RECOVERY_PRE_COMMAND before calling __reboot() recovery
cherries+=(CM_115693)

# Revert "Revert "Reenable support for non-PIE executables""
cherries+=(CM_117733)

# arm: Allow disabling PIE for dynamically linked executables
cherries+=(CM_123032)

# stagefright-plugins: Revert "codecs: Disable AC3/EAC3"
cherries+=(CM_127624)

# LockClock: Don't warn about webkit
cherries+=(CM_129496)

# Kernel: activate 184MHz step
cherries+=(LX_814)

# Kernel: OC up to 1,8GHz
cherries+=(LX_815)

# Kernel: add ZEN i/o sheduler
cherries+=(LX_816)

if [ -z $cherries ]; then
    echo -e "Nothing to cherry-pick!"
else
    ${android}/vendor/extra/repopick.py -b ${cherries[@]}
fi
