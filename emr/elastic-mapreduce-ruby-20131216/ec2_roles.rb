#
# Copyright 2011-2013 Amazon.com, Inc. or its affiliates.  All Rights Reserved.

module EC2Roles
  # These are constants for IAM Roles.
  #
  # Not to be confused with instance group roles (master, core, task).

  DEFAULT_EMR_ROLE = "aws-emr-default-ec2-role"

  def self.get_role_def(serviceprincipal)
    return %/{
      "Version":"2008-10-17",
      "Statement":[{
               "Sid":"",
               "Effect":"Allow",
               "Principal":{"Service":"#{serviceprincipal}"},
               "Action":"sts:AssumeRole"}
            ]
     }/
  end

  POLICY_DOC = %/{
  "Statement": [
    {
     "Action": [
       "cloudwatch:*",
       "dynamodb:*",
       "ec2:Describe*",
       "elasticmapreduce:Describe*",
       "rds:Describe*",
       "s3:*",
       "sdb:*",
       "sns:*",
       "sqs:*"
     ],
     "Effect": "Allow",
     "Resource": [
       "*"
        ]
    }
  ]
}/

end
