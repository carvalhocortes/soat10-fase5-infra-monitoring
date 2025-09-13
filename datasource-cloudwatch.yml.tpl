apiVersion: 1

datasources:
  - name: CloudWatch
    type: cloudwatch
    access: proxy
    isDefault: true
    uid: cloudwatch-default
    jsonData:
      authType: credentials
      assumeRoleArn: ""
      defaultRegion: ${aws_region}
    editable: true
