#!/bin/bash

# run in screen
# bash ***.sh > ***_${date}.log
#==================================================================================

SETUP=true

#===================================================================================
run_count=1

CC_SCHEMES="bbr copa cubic fillp indigo ledbat pcc sprout taova vegas verus vivace westwood"

pantheon_dir="/home/luopeng/content/pantheon/pantheon"

exper_dir="${pantheon_dir}/src/experiments/"
traces_dir="${pantheon_dir}/src/experiments/link_trace" 


analysis_dir="${pantheon_dir}/src/analysis/analyze.py"
data_dir="${pantheon_dir}/data"

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

for tput in 50 ; do :
    for latency in 20 ; do :
        setting="tput_${tput}-delay_${latency}"
        echo "=========================================================>${setting}"
        
        ${run_test_dir} \
        local --schemes "${CC_SCHEMES}" --run-times ${run_count} --data-dir ${data_dir}/combine_scenario_0327_${setting} \
        --uplink-trace ${traces_dir}/${tput}mbps.trace \
        --downlink-trace ${traces_dir}/${tput}mbps.trace \
        --prepend-mm-cmds "mm-delay ${latency}" 
    done
done






