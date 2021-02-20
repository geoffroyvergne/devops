# AWS S3

aws s3 help

## create bucket
aws s3 mb s3://geoffroyvergne-bucket

## list buckets
aws s3 ls

## delete bucket
aws s3 rb s3://geoffroyvergne-bucket

## create file
echo "hello world" | aws s3 cp - s3://geoffroyvergne-bucket/filename.txt

## read file
aws s3 cp s3://geoffroyvergne-bucket/filename.txt -
