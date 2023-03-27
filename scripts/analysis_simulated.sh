# -*- coding: utf-8 -*-
#!/bin/bash

# run in screen
# bash ***.sh > ***_${date}.log
#==================================================================================

SETUP=false

#===================================================================================
CC_SCHEMES="gail"
exper_dir="python2 /home/luo/content/code/pantheon/project/pantheon/src/experiments/"
traces_dir="/home/luo/content/code/pantheon/project/pantheon/src/experiments" 
run_count=5

analysis_dir="/home/luo/content/code/pantheon/project/pantheon/src/analysis/analyze.py"
data_dir="/home/luo/content/code/pantheon/project/pantheon/data"

setup_dir=${exper_dir}/setup.py
run_test_dir=${exper_dir}/test.py
#===================================================================================


mkdir ${data_dir}/simulated_report
for i in {4..6}; do 
    ${analysis_dir} --data-dir ${data_dir}/scenario_${i}
    mv ${data_dir}/scenario_${i}/pantheon_report.pdf  ${data_dir}/scenario_${i}/scenario_${i}_report_0321_23.pdf
    mv ${data_dir}/scenario_${i}/scenario_${i}_report_0321_23.pdf ${data_dir}/simulated_report
done




