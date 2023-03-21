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
data_dir="/home/luo/content/code/pantheon/project/pantheon/data"

setup_dir=${exper_dir}/setup.py
run_test_dir=${exper_dir}/test.py
#===================================================================================
#latency=20


#===================================================================================
# setup
if [ $SETUP == true ]; then
    echo "Setup CC algorithm"
    ${setup_dir}  --setup --schemes "${CC_SCHEMES}"
fi

for tput in 5 10 20 50 100; do :
    for latency in 10 40 80; do :
        setting="tput_${tput}-delay_${latency}"
        echo "=========================================================>${setting}"
        
        ${run_test_dir} \
        local --schemes "${CC_SCHEMES}" --run-times ${run_count} --data-dir ${data_dir}/combine_scenario_${setting} \
        --uplink-trace ${traces_dir}/${tput}mbps.trace \
        --downlink-trace ${traces_dir}/${tput}mbps.trace \
        --prepend-mm-cmds "mm-delay ${latency}" 
    done
done

#=================================================================================

mkdir ${data_dir}/combine_report
for tput in 5 10 20 50 100; do :
    for latency in 10 40 80; do :
        setting="tput_${tput}-delay_${latency}"
        
        ${analysis_dir} --data-dir ${data_dir}/combine_scenario_${setting}
        mv ${data_dir}/combine_scenario_${setting}/pantheon_report.pdf  ${data_dir}/combine_scenario_${setting}/combine_scenario_${setting}.pdf
        mv ${data_dir}/combine_scenario_${setting}/combine_scenario_${setting}.pdf ${data_dir}/combine_report
    done
done




