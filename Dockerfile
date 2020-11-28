# コードを実行するコンテナイメージ
FROM amazonlinux:2
# アクションのリポジトリからコードファイルをファイルシステムパスへコピー
#`/` of the container
COPY entrypoint.sh /entrypoint.sh
RUN yum update -y

# dockerコンテナが起動する際に実行されるコードファイル (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]