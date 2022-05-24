# google_ecommerce_data_project
A data analysis side project for google ecommerce data

This project is the data analysis project for Google Merchandise Store's website's GA data.
The main .ipynb file you can read is kmean_找出能分出有無加入購物車群集的因子.ipynb, 
the notebook is to use KMean method to find out which factor can be highly related to if the record is just view or add to cart.
The raw data is gotten by Bigquery API which can be seen in code.

Other .ipynb files are the ETL functions which I deployed them to Cloud Function.
They can read file from GCS, concat data and output data to GCS.
However, I didn't use them as the final ETL method, because I found out that Data Studio has limit for size of GCS data,
so I use Data Studio connecting to Bigquery's query to visualize and analyze data.
