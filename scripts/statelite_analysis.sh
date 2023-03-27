# -*- coding: utf-8 -*-
#!/bin/bash

# run in screen
# bash ***.sh > ***_${date}.log
#==================================================================================

SETUP=true

#===================================================================================
CC_SCHEMES="bbr copa cubic fillp ledbat pcc sprout taova vegas verus vivace westwood"
exper_dir="python2 /home/luo/content/code/pantheon/project/pantheon/src/experiments/"
traces_dir="/home/luo/content/code/pantheon/project/pantheon/src/experiments/link_trace" 
run_count=5

analysis_dir="/home/luo/content/code/pantheon/project/pantheon/src/analysis/analyze.py"
data_dir="/home/luo/content/code/pantheon/project/pantheon/data"

setup_dir=${exper_dir}/setup.py
run_test_dir=${exper_dir}/test.py
#===================================================================================

# setup
if [ $SETUP == true ]; then
    echo "Setup CC algorithm"
    ${setup_dir} --schemes "${CC_SCHEMES}"
fi

# scenario: ST0
${run_test_dir} \
local --schemes "${CC_SCHEMES}" --run-times ${run_count} --data-dir ${data_dir}/scenario_ST0 \
--uplink-trace ${traces_dir}/42mbps.trace \
--downlink-trace ${traces_dir}/42mbps.trace \
--prepend-mm-cmds "mm-delay 400 mm-loss uplink 0.0074" \
--extra-mm-link-args "--uplink-queue=droptail --uplink-queue-args=packets=1500"
echo "==============================================================================>ST0"

# scenario: ST1
${run_test_dir} \
local --schemes "${CC_SCHEMES}" --run-times ${run_count} --data-dir ${data_dir}/scenario_ST1 \
--uplink-trace ${traces_dir}/42mbps.trace \
--downlink-trace ${traces_dir}/60mbps.trace \
--prepend-mm-cmds "mm-delay 420 mm-loss uplink 0.0074" \
--extra-mm-link-args "--uplink-queue=droptail --uplink-queue-args=packets=1500"
echo "==============================================================================>ST1"


#=================================================================================
final_ST_report_dir=${data_dir}/ST_report
mkdir ${final_ST_report_dir}

for i in {0..1}; do 
    data_dir_scenario_dir=${data_dir}/scenario_ST${i}
    
    ${analysis_dir} --data-dir ${data_dir_scenario_dir}
    mv ${data_dir_scenario_dir}/pantheon_report.pdf  ${data_dir_scenario_dir}/ST${i}_report_0323_23.pdf
    mv ${data_dir_scenario_dir}/ST${i}_report_0323_23.pdf ${final_ST_report_dir}
done





