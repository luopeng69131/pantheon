#!/bin/bash

# run in screen
# bash ***.sh > ***_${date}.log
#==================================================================================

SETUP=true

#===================================================================================
#CC_SCHEMES="gail"
exper_dir="python2 /home/luo/content/code/pantheon/project/pantheon/src/experiments/"
traces_dir="/home/luo/content/code/pantheon/project/pantheon/src/experiments" 
run_count=5

analysis_dir="/home/luo/content/code/pantheon/project/pantheon/src/analysis/analyze.py"
data_dir="/home/luo/content/code/pantheon/project/pantheon/data"

setup_dir=${exper_dir}/setup.py
run_test_dir=${exper_dir}/test.py
#===================================================================================
CC_SCHEMES="bbr copa cubic fillp indigo indigo_reproduce ledbat pcc sprout taova vegas verus vivace westwood gail"
# setup
if [ $SETUP == true ]; then
    echo "Setup CC algorithm"
    ${setup_dir} --schemes "${CC_SCHEMES}"
fi

CC_SCHEMES="gail"
# scenario: 4 , Calibrated emulator (India to AWS India)
${run_test_dir} \
local --schemes "${CC_SCHEMES}" --run-times ${run_count} --data-dir ${data_dir}/scenario_4 \
--uplink-trace ${traces_dir}/100.42mbps.trace \
--downlink-trace ${traces_dir}/100.42mbps.trace \
--prepend-mm-cmds "mm-delay 27" \
--extra-mm-link-args "--uplink-queue=droptail --uplink-queue-args=packets=173"
echo "==============================================================================>4"

# scenario: 5 , Calibrated emulator (AWS Korea to China)
${run_test_dir} \
local --schemes "${CC_SCHEMES}" --run-times ${run_count} --data-dir ${data_dir}/scenario_5 \
--uplink-trace ${traces_dir}/77.72mbps.trace \
--downlink-trace ${traces_dir}/77.72mbps.trace \
--prepend-mm-cmds "mm-delay 51 mm-loss uplink 0.0006" \
--extra-mm-link-args "--uplink-queue=droptail --uplink-queue-args=packets=94"
echo "==============================================================================>5"

# run all schemes in scenario 6
CC_SCHEMES="bbr copa cubic fillp indigo indigo_reproduce ledbat pcc sprout taova vegas verus vivace westwood gail"
# scenario: 6 , Calibrated emulator (AWS California to Mexico)
${run_test_dir} \
local --schemes "${CC_SCHEMES}" --run-times ${run_count} --data-dir ${data_dir}/scenario_6 \
--uplink-trace ${traces_dir}/114.68mbps.trace --downlink-trace ${traces_dir}/114.68mbps.trace \
--prepend-mm-cmds "mm-delay 45" \
--extra-mm-link-args "--uplink-queue=droptail --uplink-queue-args=packets=450"
echo "==============================================================================>6"








