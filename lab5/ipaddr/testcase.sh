#!/bin/bash

# use a list
make clean && make ip

echo ""
echo ""

testcases=("192.168.1.1" "192.168.01.1" "192.168@1.1" "2001:0db8:85a3:0000:0000:8a2e:0370:7334" "2001:0db8:85a3:0:0:8a2e:0370:7334" "2001:0db8:85a3::8a2e:0370:7334" "02001:0db8:85a3:0000:0000:8a2e:0370:7334")
# testcases=("02001:0db8:85a3:0000:0000:8a2e:0370:7334")
for testcase in ${testcases[@]}
do
    echo "Testcase: $testcase"
    echo "$testcase" | ./ip.out
    # 换行
    echo ""

done

