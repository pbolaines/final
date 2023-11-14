  	  #!/bin/bash
      sudo yum update -y
	    sudo yum install -y httpd
	    sudo systemctl start httpd.service
	    # sudo systemctl enable httpd.service
	    sudo echo "<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Sample Deployment</title>
  <style>
    body {
      color: #ffffff;
      background-color: #0188cc;
      font-family: Arial, sans-serif;
      font-size: 14px;
    }
    
    h1 {
      font-size: 500%;
      font-weight: normal;
      margin-bottom: 0;
    }
    
    h2 {
      font-size: 200%;
      font-weight: normal;
      margin-bottom: 0;
    }
  </style>
</head>
<body>
  <div align="center">
    <h1>Congratulations-ZIYOTEK DevOps Class</h1>
    <h2>This application was deployed using Jenkins.</h2>
    <h3>Next Step is starting a new career.</h3>
    <p>For next steps, read the <a href="http://aws.amazon.com/documentation/codedeploy">AWS CodeDeploy Documentation</a>.</p>
  </div>
</body>
</html>" > /var/www/html/index.html
    
