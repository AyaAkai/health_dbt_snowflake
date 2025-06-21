from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'aya',
    'depends_on_past': False,
    'start_date': datetime(2024, 6, 1),
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

with DAG(
    'dbt_health_project_dag',
    default_args=default_args,
    description='Run dbt models for the health project',
    schedule_interval=None,  # أو مثلاً '@daily' لو عايزة تشغليه يومياً
    catchup=False,
    tags=['dbt', 'health'],
) as dag:

    dbt_run = BashOperator(
        task_id='dbt_run',
        bash_command='cd ~/Desktop/health_project/health_project && source ~/Desktop/health_project/venv/bin/activate && dbt run',
    )

    dbt_test = BashOperator(
        task_id='dbt_test',
        bash_command='cd ~/Desktop/health_project/health_project && source ~/Desktop/health_project/venv/bin/activate && dbt test',
    )

    dbt_run >> dbt_test
