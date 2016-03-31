#!/bash/bin
#### Check whether a job is running on the cluster. 
file=${PWD##*/}  ##the name of current directory
mailid='someone@somesite.com'   ##write your mailid here
pid=`cat jobsubmitted.log | cut -c 1-8`   ##modify it accordingly, this line takes  the pid data which is written to file jobsubmitted.log, cut
##is used to take first 8 characters of the file
j=0   ##declare a variable
while [ $j -eq 0 ]
do

sleep 600
qstat -u `whoami` | grep $pid    ###qstat -u `whoami` gives details of all jobs running from my account. if you have a different way to check running jobs modify this line accordingly
###the next part "grep $pid" catches the job with PID declared above.
j=$?    ###if the job is not running the value of $? is 1 after the query in line above and loop ends else it continues   
done
mail -s "drive job $file is over" $mailid <<< "The drive job is over, please check the files if desired results have been produced in `pwd`"
