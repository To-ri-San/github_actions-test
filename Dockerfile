# コードを実行するコンテナイメージ
FROM amazonlinux:2 AS core
SHELL ["/bin/bash", "-c"]
ENV EPEL_REPO="https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm"

ENV RUBY_VERSION="2.5.1" 
RUN echo timeout=60 >> /etc/yum.conf
# Install git, SSH, and other utilities
RUN set -ex \
    && yum update -y  \
    && mkdir toypo-api  \
    # && yum install -y openssh-clients \
    # && mkdir ~/.ssh \
    # && touch ~/.ssh/known_hosts \
    # && ssh-keyscan -t rsa,dsa -H github.com >> ~/.ssh/known_hosts \
    # && ssh-keyscan -t rsa,dsa -H bitbucket.org >> ~/.ssh/known_hosts \
    # && chmod 600 ~/.ssh/known_hosts \
    && yum install -y $EPEL_REPO \
    && rpm --import https://download.mono-project.com/repo/xamarin.gpg \
    && curl https://download.mono-project.com/repo/centos7-stable.repo | tee /etc/yum.repos.d/mono-centos7-stable.repo \
    && amazon-linux-extras enable corretto8 \
    && yum groupinstall -y "Development tools" \
    && yum install -y \
        #    GeoIP-devel ImageMagick asciidoc \
           openssl-devel\
           bzip2-devel \
        #    bzr bzrtools cvs cvsps \
           dpkg-dev e2fsprogs expat-devel expect fakeroot \
           glib2-devel groff gzip icu iptables jq krb5-server libargon2-devel \
           libcurl-devel libdb-devel libedit-devel libevent-devel libffi-devel \
           libicu-devel libjpeg-devel libpng-devel libserf \
           libtidy-devel libunwind libwebp-devel libxml2-devel \
           libyaml-devel libzip-devel\
           postgresql-devel procps-ng python-configobj\
           readline-devel \ 
           sgml-common \
           tar \
           tcl \
           tk  wget which \
           bzip2


RUN useradd codebuild-user

COPY entrypoint.sh /toypo-api/entrypoint.sh
COPY Gemfile /toypo-api/Gemfile
COPY Gemfile.lock /toypo-api/Gemfile.lock
RUN cd /toypo-api/ &&\
    ls -la
# AWS Tools
RUN curl -sS -o /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/aws-iam-authenticator \
    && curl -sS -o /usr/local/bin/kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/kubectl \
    && curl -sS -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest \
    && curl -sS -L https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz | tar xz -C /usr/local/bin \
    && chmod +x /usr/local/bin/kubectl /usr/local/bin/aws-iam-authenticator /usr/local/bin/ecs-cli /usr/local/bin/eksctl

##ruby
ENV RBENV_SRC_DIR="/usr/local/rbenv"

ENV PATH="/root/.rbenv/shims:$RBENV_SRC_DIR/bin:$RBENV_SRC_DIR/shims:$PATH" \
    RUBY_BUILD_SRC_DIR="$RBENV_SRC_DIR/plugins/ruby-build"

RUN set -ex \
    && git clone https://github.com/rbenv/rbenv.git $RBENV_SRC_DIR \
    && mkdir -p $RBENV_SRC_DIR/plugins \
    && git clone https://github.com/rbenv/ruby-build.git $RUBY_BUILD_SRC_DIR \
    && sh $RUBY_BUILD_SRC_DIR/install.sh

RUN rbenv install $RUBY_VERSION; rm -rf /tmp/*; rbenv global $RUBY_VERSION;ruby -v

##rails,puma,redis
RUN gem install bundler -v 2.0.2 && \
    bundle install --gemfile=/toypo-api/Gemfile

#postgreswql
RUN rpm -ivh --nodeps https://download.postgresql.org/pub/repos/yum/11/redhat/rhel-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm && \
    sed -i "s/\$releasever/7/g" "/etc/yum.repos.d/pgdg-redhat-all.repo" && \
    yum install -y postgresql11 postgresql11-contrib


# dockerコンテナが起動する際に実行されるコードファイル (`entrypoint.sh`)
ENTRYPOINT ["/toypo-api/entrypoint.sh"]