#!/bash/bin
file=${PWD##*/}
mailid='vsinha027@gmail.com'
pid=`cat jobsubmitted.log | cut -c 1-8`
j=0
while [ $j -eq 0 ]
do
sleep 600
qstat -u `whoami` | grep $pid
j=$?
done
mail -s "drive job $file is over" $mailid <<< "The drive job is over, please check the files if desired results have been produced in `pwd`"
