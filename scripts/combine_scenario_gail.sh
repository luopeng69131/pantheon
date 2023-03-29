#!/bin/bash

# run in screen
# bash ***.sh > ***_${date}.log
#==================================================================================

SETUP=true

#===================================================================================
CC_SCHEMES="bbr copa cubic fillp indigo indigo_reproduce ledbat pcc sprout taova vegas verus vivace westwood gail"
exper_dir="python2 /home/luo/content/code/pantheon/project/pantheon/src/experiments/"
traces_dir="/home/luo/content/code/pantheon/project/pantheon/src/experiments/link_trace" 
run_count=5

analysis_dir="/home/luo/content/code/pantheon/project/pantheon/src/analysis/analyze.py"
data_dir="/home/luo/content/code/pantheon/project/pantheon/data"

setup_dir=${exper_dir}/setup.py
run_test_dir=${exper_dir}/test.py
#===================================================================================
#latency=20


#===================================================================================
# setup
if [ $SETUP == true ]; then
    echo "Reboot setup CC algorithm"
    ${setup_dir} --schemes "${CC_SCHEMES}"
fi

for tput in 20 50 80; do :
    for latency in 10 20 30; do :
        setting="tput_${tput}-delay_${latency}"
        echo "=========================================================>${setting}"
        
        ${run_test_dir} \
        local --schemes "${CC_SCHEMES}" --run-times ${run_count} --data-dir ${data_dir}/combine_scenario_0327_${setting} \
        --uplink-trace ${traces_dir}/${tput}mbps.trace \
        --downlink-trace ${traces_dir}/${tput}mbps.trace \
        --prepend-mm-cmds "mm-delay ${latency}" 
    done
done

#=================================================================================

mkdir ${data_dir}/combine_report_gail_0327
for tput in 20 50 80; do :
    for latency in 10 20 30; do :
        setting="tput_${tput}-delay_${latency}"
        
        ${analysis_dir} --data-dir ${data_dir}/combine_scenario_0327_${setting}
        mv ${data_dir}/combine_scenario_0327_${setting}/pantheon_report.pdf  ${data_dir}/combine_scenario_0327_${setting}/combine_scenario_0327_${setting}.pdf
        mv ${data_dir}/combine_scenario_0327_${setting}/combine_scenario_0327_${setting}.pdf ${data_dir}/combine_report_gail_0327
    done
done

