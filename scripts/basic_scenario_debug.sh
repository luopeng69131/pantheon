#!/bin/bash

SETUP=true

#===================================================================================
CC_SCHEMES="bbr copa cubic"
exper_dir="python2 /home/luo/content/code/pantheon/project/pantheon/src/experiments/"
traces_dir="/home/luo/content/code/pantheon/project/pantheon/src/experiments" 
run_count=1


setup_dir=${exper_dir}/setup.py
run_test_dir=${exper_dir}/test.py
#===================================================================================

# setup
if [ $SETUP == true ]; then
    echo "Setup CC algorithm"
    ${setup_dir}  --setup --schemes "${CC_SCHEMES}"
fi

# scenario: 1 , Calibrated to the real path from Nepal to AWS India
${run_test_dir} \
local --schemes "${CC_SCHEMES}" --run-times ${run_count} \
--uplink-trace ${traces_dir}/0.57mbps-poisson.trace \
--downlink-trace ${traces_dir}/0.57mbps-poisson.trace \
--prepend-mm-cmds "mm-delay 28 mm-loss uplink 0.0477" \
--extra-mm-link-args "--uplink-queue=droptail --uplink-queue-args=packets=14"