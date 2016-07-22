### AWS CodeDeploy
AWS CodeDeploy is a deployment service that enables developers to automate the deployment of applications to instances and to update the applications as required.

IAM policy for bitbucket/github & AWS codeDeploy integration:
```json
     {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "s3:*"
                ],
                "Resource": "arn:aws:s3:::*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "codedeploy:*"
                ],
                "Resource": "*"
            }
        ]
    }
```

### Command to push latest code to S3
```sh
/usr/local/bin/aws deploy push --application-name myAppStaging --s3-location \
s3://myAppStagingBucket/project1.zip --ignore-hidden-files \ 
--region <region id> --source .
```

### Command to deploy
```sh
aws deploy create-deployment --application-name myAppStaging --s3-location \
bucket=myAppStagingBucket,key=project1.zip,bundleType=zip,eTag=<eTag> \ 
--deployment-group-name myAppStaging --deployment-config-name CodeDeployDefault.OneAtATime \ 
--description test1 --region <region id>
```

### AWS Regions 

```json
US East (N. Virginia)           us-east-1
US West (Oregon)                us-west-2
US West (N. California)         us-west-1
EU (Ireland)                    eu-west-1
EU (Frankfurt)                  eu-central-1
Asia Pacific (Singapore)        ap-southeast-1
Asia Pacific (Tokyo)            ap-northeast-1
Asia Pacific (Sydney)           ap-southeast-2
Asia Pacific (Seoul)            ap-northeast-2
South America (Sao Paulo)       sa-east-1
```

### CodeDeploy config
```sh
  Logfile:
    - /var/log/aws/codedeploy-agent/codedeploy-agent.log

  Deployment Instructions:
    - ls /opt/codedeploy-agent/deployment-root/deployment-instructions

   Find Deployment ID, Source file & Log:
    - ls /opt/codedeploy-agent/deployment-root/*/*
```

### Links

* [What is codedeploy] - http://docs.aws.amazon.com/codedeploy/latest/userguide/welcome.html
* [Github & CodeDeploy] - https://blogs.aws.amazon.com/application-management/post/Tx33XKAKURCCW83/Automatically-Deploy-from-GitHub-Using-AWS-CodeDeploy
* [Bitbucket & CodeDeploy] - https://aws.amazon.com/blogs/apn/announcing-atlassian-bitbucket-support-for-aws-codedeploy/
* [Verify agent is running] - http://docs.aws.amazon.com/codedeploy/latest/userguide/how-to-run-agent-verify.html
