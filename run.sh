spark-sql --conf spark.sql.warehouse.dir=/user/spark/warehouse \
  --packages io.delta:delta-spark_2.12:3.1.0 \
  --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" \
  --conf "spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog" \
  -f /home/hadoop/emr/app.sql \
  -d USERNAME=`whoami` \
  --verbose >> /home/hadoop/emr/app.log

hdfs dfs -rm -R -skipTrash /user/`whoami`/nyse_data/*