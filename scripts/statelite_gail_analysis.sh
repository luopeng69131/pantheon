# -*- coding: utf-8 -*-
#!/bin/bash

# run in screen
# bash ***.sh > ***_${date}.log
#==================================================================================

SETUP=true

#===================================================================================
CC_SCHEMES="gail"
exper_dir="python2 /home/luo/content/code/pantheon/project/pantheon/src/experiments/"
traces_dir="/home/luo/content/code/pantheon/project/pantheon/src/experiments/link_trace" 
run_count=5

analysis_dir="/home/luo/content/code/pantheon/project/pantheon/src/analysis/analyze.py"
data_dir="/home/luo/content/code/pantheon/project/pantheon/data"

setup_dir=${exper_dir}/setup.py
run_test_dir=${exper_dir}/test.py
#===================================================================================


final_ST_report_dir=${data_dir}/ST_report
mkdir ${final_ST_report_dir}

for i in {0..1}; do 
    data_dir_scenario_dir=${data_dir}/scenario_ST${i}
    
    ${analysis_dir} --data-dir ${data_dir_scenario_dir}
    mv ${data_dir_scenario_dir}/pantheon_report.pdf  ${data_dir_scenario_dir}/ST${i}_report_gail_0327_23.pdf
    mv ${data_dir_scenario_dir}/ST${i}_report_gail_0327_23.pdf ${final_ST_report_dir}
done