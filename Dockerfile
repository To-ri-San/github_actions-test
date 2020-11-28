# コードを実行するコンテナイメージ
FROM amazonlinux:2
# アクションのリポジトリからコードファイルをファイルシステムパスへコピー
ENV RUBY_VERSION="2.5.1" 
#`/` of the container

RUN yum update -y && \
    mkdir toypo-api
#COPY * /toypo-api/
COPY  entrypoint.sh /entrypoint.sh
RUN ls -la toypo-api/ 

# dockerコンテナが起動する際に実行されるコードファイル (`entrypoint.sh`)
ENTRYPOINT ["entrypoint.sh"]