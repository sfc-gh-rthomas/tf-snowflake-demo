terraform { 
 required_providers {
  snowflake = {
   source = "chanzuckerberg/snowflake" version = "0.25.16"
           } 
      }
}
provider "snowflake" {
role = "TF_ROLE" }
 
 resource "snowflake_database" "dbt_ord_dev" { name = "DBT_ORD_DEV"
}
resource "snowflake_warehouse" "dbt_dev_wh" { name = "DBT_DEV_WH"
warehouse_size = "small"
auto_resume = true
auto_suspend = 60
initially_suspended = true }
resource "snowflake_warehouse" "dbt_prod_wh" { name = "DBT_PROD_WH"
warehouse_size = "small"
auto_resume = true
auto_suspend = 60
initially_suspended = true }
resource "snowflake_database" "dbt_ord_prod" { name = "DBT_ORD_PROD"
}
resource "snowflake_database_grant" "grant_dev_db_usage" { database_name = snowflake_database.dbt_ord_dev.name privilege = "USAGE"
roles = ["DBT_DEV_ROLE"]
with_grant_option = false }
resource "snowflake_database_grant" "grant_prod_db_usage" { database_name = snowflake_database.dbt_ord_prod.name privilege = "USAGE"
roles = ["DBT_PROD_ROLE"]
with_grant_option = false }
resource "snowflake_database_grant" "grant_dev_db_create_sch" { database_name = snowflake_database.dbt_ord_dev.name privilege = "CREATE SCHEMA"
roles = ["DBT_DEV_ROLE"]
with_grant_option = false }

 resource "snowflake_database_grant" "grant_prod_db_create_sch" { database_name = snowflake_database.dbt_ord_prod.name privilege = "CREATE SCHEMA"
roles = ["DBT_PROD_ROLE"]
with_grant_option = false }
resource "snowflake_warehouse_grant" "grant_dev_wh_usage" { warehouse_name = snowflake_warehouse.dbt_dev_wh.name privilege = "USAGE"
roles = [
"DBT_DEV_ROLE", ]
with_grant_option = false }
resource "snowflake_warehouse_grant" "grant_dev_wh_modify" { warehouse_name = snowflake_warehouse.dbt_dev_wh.name privilege = "MODIFY"
roles = [
"DBT_DEV_ROLE", ]
with_grant_option = false }
resource "snowflake_warehouse_grant" "grant_prod_wh_usage" { warehouse_name = snowflake_warehouse.dbt_prod_wh.name privilege = "USAGE"
roles = [
"DBT_PROD_ROLE", ]
with_grant_option = false }
resource "snowflake_warehouse_grant" "grant_prod_wh_modify" { warehouse_name = snowflake_warehouse.dbt_prod_wh.name privilege = "MODIFY"
roles = [
"DBT_PROD_ROLE", ]
with_grant_option = false }

 resource "snowflake_stage" "dev_stage" {
name = "EXT_STAGE_SAMPLE_DATA"
url = "s3://snowflake-workshop-lab/vhol_customer_order/" database = snowflake_database.dbt_ord_dev.name
schema = "PUBLIC"
}
resource "snowflake_stage" "prod_stage" {
name = "EXT_STAGE_SAMPLE_DATA"
url = "s3://snowflake-workshop-lab/vhol_customer_order/" database = snowflake_database.dbt_ord_prod.name
schema = "PUBLIC"
}
resource "snowflake_stage_grant" "grant_dev_stage" { database_name = snowflake_stage.dev_stage.database schema_name = snowflake_stage.dev_stage.schema roles = ["DBT_DEV_ROLE"]
privilege = "OWNERSHIP"
stage_name = snowflake_stage.dev_stage.name }
resource "snowflake_stage_grant" "grant_prod_stage" { database_name = snowflake_stage.prod_stage.database schema_name = snowflake_stage.prod_stage.schema roles = ["DBT_PROD_ROLE"]
privilege = "OWNERSHIP"
stage_name = snowflake_stage.prod_stage.name }
resource "snowflake_schema_grant" "grant_dev_public_schema" { database_name = snowflake_database.dbt_ord_dev.name schema_name = "PUBLIC"
privilege = "USAGE"
roles = ["DBT_DEV_ROLE"]
with_grant_option = false }
resource "snowflake_schema_grant" "grant_prod_public_schema" { database_name = snowflake_database.dbt_ord_prod.name schema_name = "PUBLIC"
privilege = "USAGE"
roles = ["DBT_PROD_ROLE"] with_grant_option = false

 }
resource "snowflake_schema_grant" "grant_dev_public_schema_fileformat" {
database_name = snowflake_database.dbt_ord_dev.name schema_name = "PUBLIC"
privilege = "CREATE FILE FORMAT"
roles = ["DBT_DEV_ROLE"]
with_grant_option = false }
resource "snowflake_schema_grant" "grant_prod_public_schema_fileformat" { database_name = snowflake_database.dbt_ord_prod.name
schema_name = "PUBLIC"
privilege = "CREATE FILE FORMAT"
roles = ["DBT_PROD_ROLE"]
with_grant_option = false }
resource "snowflake_schema_grant" "grant_dev_public_schema_exttable" { database_name = snowflake_database.dbt_ord_dev.name
schema_name = "PUBLIC"
privilege = "CREATE EXTERNAL TABLE"
roles = ["DBT_DEV_ROLE"]
with_grant_option = false }
resource "snowflake_schema_grant" "grant_prod_public_schema_exttable" { database_name = snowflake_database.dbt_ord_prod.name
schema_name = "PUBLIC"
privilege = "CREATE EXTERNAL TABLE"
roles = ["DBT_PROD_ROLE"]
with_grant_option = false }
resource "snowflake_schema_grant" "grant_dev_public_schema_table" { database_name = snowflake_database.dbt_ord_dev.name schema_name = "PUBLIC"
privilege = "CREATE TABLE"
roles = ["DBT_DEV_ROLE"]
with_grant_option = false }
resource "snowflake_schema_grant" "grant_prod_public_schema_table" { database_name = snowflake_database.dbt_ord_prod.name schema_name = "PUBLIC"
privilege = "CREATE TABLE"

roles = ["DBT_PROD_ROLE"]
with_grant_option = false }
resource "snowflake_schema_grant" "grant_dev_public_schema_view" { database_name = snowflake_database.dbt_ord_dev.name schema_name = "PUBLIC"
privilege = "CREATE VIEW"
roles = ["DBT_DEV_ROLE"]
with_grant_option = false }
resource "snowflake_schema_grant" "grant_prod_public_schema_view" { database_name = snowflake_database.dbt_ord_prod.name schema_name = "PUBLIC"
privilege = "CREATE VIEW"
roles = ["DBT_PROD_ROLE"]
with_grant_option = false }
