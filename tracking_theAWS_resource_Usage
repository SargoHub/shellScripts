#resouces tracked EC2, S3, Lambda, IAM
#Every day at 9 AM, this script should run and this info is given to your manager or a reporting dashboard
#The sheel script creates a file with all the resource info
#the script can be integrated with a cron job
#aws cli is a pre-requisite for this 
#configure your aws user using the aws configure command (giving the access key and secret access key)

vim aws_resource_tracker.sh

#!/bib/bash
#####
# Author: Saransh
# Use: To report the AWS resource usage
#Date written: 16-06-2024
#Version: V1
# Resources it can track EC2, S3, Lambda, IAM users

set -x #to get in the debug mode (lists the command first)

#lits S3 buckets
echo "S3 bucket list"
aws s3 ls > resourcestracker.txt          #pushing this info into a file 

#list EC2 instances
echo "ec2 lists"
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId' > resourcestracker.txt     #jq is JSON parcer use to filter from the JSON output
jq 
#list the lambda functions
echo "list the lambda funstions"
aws lambda list-functions > resourcestracker.txt

#to list IAM users
echo "IAM users list"
aws iam list-users > resourcestracker.txt


#####################The scripts end here

#to integrate this script with the cron tab

crontab -e
0 6 * * * /path/to/aws_resource_tracker.sh









