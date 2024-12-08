# rds_proxy_handson

- 概要
    - Lambda→RDS Proxy→RDSの接続をやってみた
- ToDo
    - RDS Proxyへの接続にTLSを使用していない状態になっているので、TLS接続を有効化にした場合もやってみる
    - Lambdaのアーカイブを作成する際に、フォルダごとアーカイブすることができていない。以下の例で言うと、moduleフォルダ配下にあるtest.pyはフォルダに格納されていない状態でLambdaにアップロードされる。
        ```
        ├── lambda
        │   │   └── lambda_proxy_access
        │   │       ├── index.py
        │   │       ├── module
        │   │       │   └── test.py
        │   │       └── requirements.txt
        ```
    - 今回はSecretManagerに格納したパスワードを使用してデータベースに接続しているが、IAM認証の接続も試してみたい