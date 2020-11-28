# コードを実行するコンテナイメージ
FROM amazonlinux:2
# アクションのリポジトリからコードファイルをファイルシステムパスへコピー
ENV RUBY_VERSION="2.5.1" \
#`/` of the container
COPY * /
RUN yum update -y

# dockerコンテナが起動する際に実行されるコードファイル (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]