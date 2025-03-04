user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y java-1.8.0-openjdk-devel
              wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
              rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
              sudo yum install jenkins -y
              sudo systemctl start jenkins
              sudo systemctl enable jenkins
              EOF

