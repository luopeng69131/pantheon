#!/bin/bash

# run in screen
# bash ***.sh > ***_${date}.log
#==================================================================================

SETUP=true

#===================================================================================
run_count=1

#CC_SCHEMES="bbr copa cubic fillp indigo ledbat pcc sprout taova vegas verus vivace westwood indigo_reproduce gail"
CC_SCHEMES="bbr indigo indigo_reproduce gail"

remote_addr="luopeng@106.12.143.4"
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

echo "=========================================================>running"

${run_test_dir} remote \
--schemes "${CC_SCHEMES}" \
--run-times ${run_count} --data-dir ${data_dir}/test_remote_all \
${remote_addr}:${pantheon_dir}

${analysis_dir} --data-dir ${data_dir}/test_remote_all/








