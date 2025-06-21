Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

# Health Habits & Chronic Diseases Data Engineering Pipeline

This end-to-end data engineering project analyzes the relationship between health habits (like sleep, exercise, junk food intake) and chronic diseases (diabetes, hypertension, heart disease). The pipeline simulates real-world data, processes it using modern tools, and delivers actionable insights through an interactive dashboard.

---

## Objective

To build a modern, automated, cloud-based data pipeline that:
- Generates and ingests synthetic health habit data (1 million rows)
- Stores and transforms data in Snowflake using dbt
- Automates orchestration with Apache Airflow
- Visualizes insights on Power BI Service

---

## Tech Stack

| Layer           | Tool                    |
|----------------|--------------------------|
| Data Generation | Python (Faker, Pandas, NumPy) |
| Storage & Warehousing | Snowflake (Free Tier) |
| Transformations | dbt Core                 |
| Workflow Orchestration | Apache Airflow (Local)  |
| Dashboard & BI | Power BI Desktop + Service |

---

## Pipeline Flow

1. **🧬 Data Generation**  
   Generate 1M records using Python scripts and ingest into Snowflake (raw schema)

2. **🏗Schema Design (Snowflake)**  
   - `raw.health_data`  
   - `staging.stg_health_data`  
   - `dwh.fact_health_status`  
   - `dwh.dim_person`, `dwh.dim_time`

3. **dbt Models & Transformations**  
   - Models organized under `models/staging` and `models/dwh`
   - Implemented flags: `low_sleep`, `low_exercise`, `junk_food`, `old_age`, `risk_score`
   - dbt tests: `not_null`, `unique`, `accepted_values`

4. **Automation (Airflow)**  
   - Airflow DAG runs `dbt run` on schedule or trigger
   - Ensures freshness and CI compatibility

5. **Power BI Dashboard**  
   - Connected live to Snowflake
   - Includes pages:
     - Disease Breakdown by Risk Factors
     - Gender & Age Analysis
     - Geo Distribution (Map by Country)
   - Published on Power BI Service

---

## Data Quality Checks

Implemented dbt schema tests:
- `not_null` on primary keys and date fields
- `unique` on `person_id`
- `accepted_values` on flags and scores

---

## Run Locally

### 1. Clone the repo

```bash
git clone https://github.com/AyaAkai/health_dbt_snowflake.git
cd health_dbt_snowflake
