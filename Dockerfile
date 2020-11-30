# コードを実行するコンテナイメージ
FROM centos:7
# アクションのリポジトリからコードファイルをファイルシステムパスへコピー
ENV RUBY_VERSION="2.5.1" 
#`/` of the container

RUN yum update -y && \
    mkdir toypo-api && \
    yum install -y \
    gcc \
    make \
    bzip2\
    openssl-devel\
    readline-devel\
    zlib-devel \
    git \
    which

COPY  * /toypo-api/
COPY entrypoint.sh /toypo-api/entrypoint.sh
RUN ls -la toypo-api/ 

#**************** RUBY *********************************************************
# RUN set -ex \
#     && git clone https://github.com/rbenv/rbenv.git ~/.rbenv \
#     &&  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile \
#     && ~/.rbenv/bin/rbenv init \
#     && exec $SHELL -l \
#     && mkdir -p "$(rbenv root)"/plugins \
#     && git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build \
#     && curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash \
#     && rbenv install $RUBY_VERSION && rbenv global $RUBY_VERSION \
 #   && ruby -v
ENV RBENV_SRC_DIR="/usr/local/rbenv"

# ENV PATH="/root/.rbenv/shims:\
ENV PATH="$RBENV_SRC_DIR/bin:$RBENV_SRC_DIR/shims:$PATH" \
    RUBY_BUILD_SRC_DIR="$RBENV_SRC_DIR/plugins/ruby-build"

RUN set -ex \
    && git clone https://github.com/rbenv/rbenv.git $RBENV_SRC_DIR \
    && mkdir -p $RBENV_SRC_DIR/plugins \
    && source ~/.bashrc \
    ##&& git clone https://github.com/rbenv/ruby-build.git $RUBY_BUILD_SRC_DIR \
    && git clone https://github.com/sstephenson/ruby-build.git $RUBY_BUILD_SRC_DIR \
    && echo '# rbenv' >> ~/.bashrc \
    && echo 'export PATH=$RBENV_SRC_DIR/bin:$PATH' >> ~/.bashrc \
    && echo 'eval "$(rbenv init -)"' >> ~/.bashrc \
    && curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash \
    # && sh $RUBY_BUILD_SRC_DIR/install.sh \
    && rbenv install $RUBY_VERSION && rbenv global $RUBY_VERSION 
    # && ruby -v
#**************** END RUBY *****************************************************

# dockerコンテナが起動する際に実行されるコードファイル (`entrypoint.sh`)
ENTRYPOINT ["/toypo-api/entrypoint.sh"]