<h1 align="center">Apache Atlas Data Governance PoC</h1>

<p align="center">
Production-style Apache Atlas Proof of Concept demonstrating metadata ingestion,
data lineage, classification tagging, and governance workflows using the Hadoop ecosystem.
</p>

<hr>

<h2>Project Overview</h2>

<p>
This project demonstrates how Apache Atlas can be deployed in a local
single-node data platform to implement enterprise-style data governance.
</p>

<p>
The system integrates Hadoop, Hive, HBase, Elasticsearch, and Apache Atlas
to capture metadata automatically and visualize data lineage across datasets.
</p>

<p>
The goal of this PoC is to simulate a real-world data governance platform
used in modern data lake architectures.
</p>

<hr>


Data flow in this system:
</p>

<ul>
<li>Hive executes queries</li>
<li>Hive Hook sends metadata events to Apache Atlas</li>
<li>Atlas stores metadata in HBase</li>
<li>Elasticsearch indexes metadata for search</li>
<li>Atlas UI visualizes lineage and governance data</li>
</ul>

<hr>

<h2>Technology Stack</h2>

<table>
<tr>
<th>Component</th>
<th>Version</th>
<th>Purpose</th>
</tr>

<tr>
<td>Apache Hadoop</td>
<td>3.3.6</td>
<td>Distributed storage and processing framework</td>
</tr>

<tr>
<td>Apache Hive</td>
<td>3.1.3</td>
<td>SQL query engine for the data lake</td>
</tr>

<tr>
<td>Apache HBase</td>
<td>2.5.x</td>
<td>Metadata storage backend for Atlas</td>
</tr>

<tr>
<td>Apache Atlas</td>
<td>2.4.0</td>
<td>Metadata catalog and governance engine</td>
</tr>

<tr>
<td>Elasticsearch</td>
<td>7.17</td>
<td>Search indexing for metadata</td>
</tr>

<tr>
<td>Java</td>
<td>OpenJDK 8</td>
<td>Runtime environment</td>
</tr>

</table>

<hr>

<h2>Features Demonstrated</h2>

<ul>

<li>Automated metadata ingestion from Hive</li>
<li>Hive table and column discovery</li>
<li>Column-level lineage tracking</li>
<li>Data transformation lineage</li>
<li>Data classification (PII tagging)</li>
<li>Tag propagation across datasets</li>
<li>Impact analysis for downstream dependencies</li>

</ul>

<hr>

<h2>Project Structure</h2>

<pre>
atlas-governance-poc/



configs/
  atlas-application.properties
  atlas-env.sh
  hive-site.xml
  hbase-site.xml

scripts/
  start_stack.sh
  stop_stack.sh
  hive_test_queries.sql

data/
  customers.csv

screenshots/
  atlas_ui_table.png
  lineage_graph.png
  classification_pii.png

docs/
  installation_steps.md
  troubleshooting.md

README.md
</pre>

<hr>

<h2>Setup Instructions</h2>

<h3>1. Start Hadoop</h3>

<pre>
start-dfs.sh
</pre>

<h3>2. Start HBase</h3>

<pre>
start-hbase.sh
</pre>

<h3>3. Start Elasticsearch</h3>

<pre>
nohup ~/elasticsearch/bin/elasticsearch &
</pre>

<h3>4. Start Apache Atlas</h3>

<pre>
cd ~/atlas
bin/atlas_start.py
</pre>

<h3>5. Access Atlas UI</h3>

<pre>
http://localhost:21000
</pre>

Default credentials:

<pre>
admin
admin
</pre>

<hr>

<h2>Hive Metadata Ingestion Test</h2>

Run Hive queries to generate metadata.

<pre>
CREATE DATABASE atlas_test;

USE atlas_test;

CREATE TABLE test_table(id INT);

CREATE TABLE test_table_2 AS
SELECT id FROM test_table;
</pre>

After execution:

<ul>
<li>Atlas automatically captures table metadata</li>
<li>Lineage relationships are created</li>
</ul>

<hr>



<p>
Atlas records transformation lineage when a dataset is derived from another dataset.
</p>

Example relationship:

<pre>
test_table  →  test_table_2
</pre>

<hr>



<p>
A <b>PII classification</b> can be applied to sensitive columns.
</p>

Example:

<ul>
<li>Column <b>id</b> tagged as <b>PII</b></li>
<li>Classification propagates to downstream datasets</li>
</ul>

<hr>

<h2>Impact Analysis</h2>

Atlas allows users to analyze downstream dependencies.

If a dataset is modified or deleted, Atlas can show:

<ul>
<li>Which tables depend on it</li>
<li>Which ETL jobs are affected</li>
<li>Which columns propagate sensitive tags</li>
</ul>

<hr>

<h2>Example Governance Workflow</h2>

<ol>

<li>Ingest dataset into Hive</li>

<li>Hive Hook sends metadata to Atlas</li>

<li>Atlas builds lineage graph</li>

<li>Apply classifications (e.g., PII)</li>

<li>Tags propagate through lineage</li>

<li>Impact analysis shows downstream dependencies</li>

</ol>

<hr>





<hr>

<h2>Troubleshooting</h2>

<h3>Atlas UI not accessible</h3>

Check if Atlas process is running:

<pre>
jps
</pre>

Expected output:

<pre>
Atlas
HMaster
HRegionServer
QuorumPeerMain
Elasticsearch
</pre>

<h3>ZooKeeper connection errors</h3>

Ensure ZooKeeper is running:

<pre>
ss -tulnp | grep 2181
</pre>

<hr>

<h2>Future Improvements</h2>

<ul>

<li>Spark metadata ingestion</li>
<li>Apache Ranger integration</li>
<li>Role-based access control</li>
<li>Kubernetes deployment</li>
<li>Automated metadata scanning</li>

</ul>

<hr>

