# コードを実行するコンテナイメージ
FROM amazonlinux:2
SHELL ["/bin/bash", "-c"]
# アクションのリポジトリからコードファイルをファイルシステムパスへコピー
ENV RUBY_VERSION="2.5.1" 
#`/` of the container

RUN yum update -y && \
    mkdir toypo-api && \
    yum install -y \
    gcc \
    gcc-c++ \
    make \
    bzip2\
    openssl-devel\
    readline-devel\
    zlib-devel \
    git \
    which

COPY  * /toypo-api/
COPY entrypoint.sh /toypo-api/entrypoint.sh
RUN  touch ~/.bashrc 

#**************** RUBY *********************************************************

# ENV RBENV_SRC_DIR="/usr/local/rbenv"

# ENV PATH="/root/.rbenv/shims:$RBENV_SRC_DIR/bin:$RBENV_SRC_DIR/shims:$PATH" \
#     RUBY_BUILD_SRC_DIR="$RBENV_SRC_DIR/plugins/ruby-build"
ENV PATH="$HOME/.rbenv/bin:$PATH"
RUN set -ex \
    # && git clone https://github.com/rbenv/rbenv.git $RBENV_SRC_DIR \
    && git clone https://github.com/sstephenson/rbenv.git ~/.rbenv \
    && git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build \
    # && mkdir -p $RBENV_SRC_DIR/plugins \
    && source ~/.bashrc 
ENV PATH="$HOME/.rbenv/bin:$PATH"
RUN echo '# rbenv' >> ~/.bashrc \
    && echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc \
    && echo 'eval "$(rbenv init -)"' >> ~/.bashrc \
    ##&& git clone https://github.com/rbenv/ruby-build.git $RUBY_BUILD_SRC_DIR \
    # && git clone https://github.com/sstephenson/ruby-build.git $RUBY_BUILD_SRC_DIR \
    && curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash \
    # && sh $RUBY_BUILD_SRC_DIR/install.sh \
    && rbenv install $RUBY_VERSION && rbenv global $RUBY_VERSION 
    # && ruby -v
#**************** END RUBY *****************************************************

# dockerコンテナが起動する際に実行されるコードファイル (`entrypoint.sh`)
ENTRYPOINT ["/toypo-api/entrypoint.sh"]