FROM jenkins/jenkins:lts

# docker daemonの動いているホストのGIDを指定する
# docker run -v /var/run/docker.sock:/var/run/docker.sock で
# ホストのdocker daemonを共有する前提
ENV DOCKER_GROUP_GID 501

USER root

# docker のバイナリをinstall
RUN wget https://download.docker.com/linux/static/stable/x86_64/docker-18.03.1-ce.tgz
RUN tar -xvf docker-18.03.1-ce.tgz
RUN mv docker/* /usr/bin/

# jenkins userでもdockerが使えるようにする
RUN groupadd -o -g ${DOCKER_GROUP_GID} docker
RUN usermod -g docker jenkins

# jenkinsのuidは1000
# jenkinsユーザを利用するのがベストプラクティス
USER jenkins
