FROM jenkins/jenkins:lts

USER root

RUN apt-get update
RUN apt-get install -y maven

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

RUN npm install -g typescript
RUN npm install -g @angular/cli --unsafe

USER jenkins
