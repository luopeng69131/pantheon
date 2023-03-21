#!/bin/bash

# run in screen
# bash ***.sh > ***_${date}.log
#==================================================================================

SETUP=false

#===================================================================================
CC_SCHEMES="bbr copa cubic fillp indigo indigo_reproduce ledbat pcc sprout taova vegas verus vivace westwood"
exper_dir="python2 /home/luo/content/code/pantheon/project/pantheon/src/experiments/"
traces_dir="/home/luo/content/code/pantheon/project/pantheon/src/experiments" 
run_count=5

analysis_dir="/home/luo/content/code/pantheon/project/pantheon/src/analysis/analyze.py"
data_dir="/home/luo/content/code/pantheon/project/pantheon/src/data"

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
local --schemes "${CC_SCHEMES}" --run-times ${run_count} --data-dir ${data_dir}/scenario_1 \
--uplink-trace ${traces_dir}/0.57mbps-poisson.trace \
--downlink-trace ${traces_dir}/0.57mbps-poisson.trace \
--prepend-mm-cmds "mm-delay 28 mm-loss uplink 0.0477" \
--extra-mm-link-args "--uplink-queue=droptail --uplink-queue-args=packets=14"
echo "==============================================================================>1"

# scenario: 2 , Calibrated emulator (Mexico cellular to AWS California)
${run_test_dir} \
local --schemes "${CC_SCHEMES}" --run-times ${run_count} --data-dir ${data_dir}/scenario_2 \
--uplink-trace ${traces_dir}/2.64mbps-poisson.trace \
--downlink-trace ${traces_dir}/2.64mbps-poisson.trace \
--prepend-mm-cmds "mm-delay 88" \
--extra-mm-link-args "--uplink-queue=droptail --uplink-queue-args=packets=130"
echo "==============================================================================>2"

# scenario: 3 , Calibrated emulator (AWS Brazil to Colombia cellular)
${run_test_dir} \
local --schemes "${CC_SCHEMES}" --run-times ${run_count} --data-dir ${data_dir}/scenario_3 \
--uplink-trace ${traces_dir}/3.04mbps-poisson.trace \
--downlink-trace ${traces_dir}/3.04mbps-poisson.trace \
--prepend-mm-cmds "mm-delay 130" \
--extra-mm-link-args "--uplink-queue=droptail --uplink-queue-args=packets=426"
echo "==============================================================================>3"

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

# scenario: 6 , Calibrated emulator (AWS California to Mexico)
${run_test_dir} \
local --schemes "${CC_SCHEMES}" --run-times ${run_count} --data-dir ${data_dir}/scenario_6 \
--uplink-trace ${traces_dir}/77.72mbps.trace --downlink-trace ${traces_dir}/77.72mbps.trace \
--prepend-mm-cmds "mm-delay 51 mm-loss uplink 0.0006" \
--extra-mm-link-args "--uplink-queue=droptail --uplink-queue-args=packets=94"
echo "==============================================================================>6"

#=================================================================================
for i in {1..6}; do 
    ${analysis_dir} --data-dir ${data_dir}/scenario_${i}
    mv ${data_dir}/scenario_${i}/pantheon_report.pdf  ${data_dir}/scenario_${i}/scenario_${i}_report.pdf
done



