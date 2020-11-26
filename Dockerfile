# コードを実行するコンテナイメージ
FROM ubuntu:latest
# アクションのリポジトリからコードファイルをファイルシステムパスへコピー
#`/` of the containerasd
COPY entrypoint.sh /entrypoint.sh

# dockerコンテナが起動する際に実行されるコードファイル (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]