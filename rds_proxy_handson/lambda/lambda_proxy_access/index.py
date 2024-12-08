import boto3
import os
import json
import pymysql

def lambda_handler(event, context):
    secret_arn = os.environ['SECRET_ARN']
    region = os.environ.get('AWS_REGION', 'ap-northeast-1')

    # Secrets Managerクライアントを作成
    secrets_client = boto3.client('secretsmanager', region_name=region)

    # Secretの値を取得
    response = secrets_client.get_secret_value(SecretId=secret_arn)
    secret = json.loads(response['SecretString'])

    # 取得した接続情報
    db_host = os.environ['DB_HOST']
    db_username = secret['username']
    db_password = secret['password']
    db_name = os.environ['DB_NAME']

    # データベースに接続
    connection = None  # connection を初期化
    try:
        connection = pymysql.connect(
            host=db_host,
            user=db_username,
            password=db_password,
            database=db_name,
            connect_timeout=5,
            cursorclass=pymysql.cursors.DictCursor
        )
        print("Connected to database")
        
        # テーブル作成
        create_table_query = """
        CREATE TABLE IF NOT EXISTS SampleTable (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(255) NOT NULL,
            age INT NOT NULL
        );
        """
        with connection.cursor() as cursor:
            cursor.execute(create_table_query)
            connection.commit()
            print("Table created successfully")

        # データ挿入
        
        insert_data_query = "INSERT INTO SampleTable (name, age) VALUES (%s, %s)"
        data_to_insert = [("Alice", 30), ("Bob", 25), ("Charlie", 35)]
        with connection.cursor() as cursor:
            cursor.executemany(insert_data_query, data_to_insert)
            connection.commit()
            print(f"{cursor.rowcount} rows inserted successfully")

        # データ閲覧
        select_query = "SELECT * FROM SampleTable"
        with connection.cursor() as cursor:
            cursor.execute(select_query)
            results = cursor.fetchall()
            print("Retrieved data:")
            for row in results:
                print(row)

    except pymysql.MySQLError as e:
        print(f"ERROR: Could not connect to database. {e}")
        return {
            'statusCode': 500,
            'body': json.dumps('Database connection failed')
        }

    finally:
        if connection:
            connection.close()
            print("Connection closed")

    return {
        'statusCode': 200,
        'body': json.dumps('Success')
    }
