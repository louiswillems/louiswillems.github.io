---
layout: post
title: Content-based recommendation system using neural networks - Part 2
---
<br>
<br>
This post builds the data we will use for creating our content based model. We'll collect the data via a collection of SQL queries from a Google Analytics dataset in BigQuery.
Our goal is to recommend an article for a visitor (Client ID) to our site.

This post relies on files created in the [Content-based recommendation system using neural networks - Part 1](https://louiswillems.github.io/2019/01/15/Content-based-recommendation-system-using-neural-networks-Part-1)

In this post we will illustrates:
* how to build feature columns for a model using tf.feature_column
* how to create custom evaluation metrics and add them to Tensorboard
* how to train a model and make predictions with the saved model


```python
%bash
pip install tensorflow==1.8.0
pip install tensorflow-hub==0.3.0
pip install tensorboard==1.8.0
```

```python
import os
import tensorflow as tf
import numpy as np
import tensorflow_hub as hub
import shutil

PROJECT = 'quebecor-numerique' # REPLACE WITH YOUR PROJECT ID
BUCKET = 'numericanalytics' # REPLACE WITH YOUR BUCKET NAME
REGION = 'us-central1' # REPLACE WITH YOUR BUCKET REGION e.g. us-central1

# do not change these
os.environ['PROJECT'] = PROJECT
os.environ['BUCKET'] = BUCKET
os.environ['REGION'] = REGION
os.environ['TFVERSION'] = '1.8'

%bash
gcloud config set project $PROJECT
gcloud config set compute/region $REGION
```

We will use this helper function to write lists containing article ids, categories, and authors for each article in our database to local file.

```python
def write_list_to_disk(my_list, filename):
  with open(filename, 'w') as f:
    for item in my_list:
        line = "%s\n" % item
```
<br>
<br>
## 1. Build all the features columns for the content-based model
<br>
To start, we'll load the list of categories, authors and content_ids that we created in the previous Post.
```python
authors_list = open("authors.txt").read().splitlines()
content_ids_list = open("content_ids.txt").read().splitlines()
mean_months_since_epoch = 523
medium_list = open("medium.txt").read().splitlines() # categorical_column_with_vocabulary_list
```
In the cell below we'll define the feature columns to use in our model. If necessary, remind yourself the various feature columns to use.
For the embedded_title_column feature column, use a Tensorflow Hub Module to create an embedding of the article title. Since the articles and titles are in German, you'll want to use a German language embedding module.
Explore the text embedding Tensorflow Hub modules available here. Filter by setting the language to 'German'. The 50 dimensional embedding should be sufficient for our purposes.

<br>
```python
embedded_title_column = hub.text_embedding_column(key="title", module_spec="https://tfhub.dev/google/nnlm-de-dim50/1", trainable=False)

content_id_column = tf.feature_column.categorical_column_with_hash_bucket(key="content_id", hash_bucket_size= len(content_ids_list) + 1)
embedded_content_column = tf.feature_column.embedding_column(categorical_column=content_id_column, dimension=10)

author_column = tf.feature_column.categorical_column_with_hash_bucket(key="author", hash_bucket_size=len(authors_list) + 1)
embedded_author_column = tf.feature_column.embedding_column(categorical_column=author_column, dimension=3)

months_since_epoch_boundaries = list(range(400,700,20))
months_since_epoch_column = tf.feature_column.numeric_column(key="months_since_epoch")
months_since_epoch_bucketized = tf.feature_column.bucketized_column(source_column = months_since_epoch_column, boundaries = months_since_epoch_boundaries)

medium_column_categorical = tf.feature_column.categorical_column_with_vocabulary_list(key="medium", vocabulary_list=medium_list, num_oov_buckets=1)
medium_column = tf.feature_column.indicator_column(medium_column_categorical)


crossed_months_since_medium_column = tf.feature_column.indicator_column(tf.feature_column.crossed_column(
  keys = [medium_column_categorical, months_since_epoch_bucketized], 
  hash_bucket_size = len(months_since_epoch_boundaries) * (len(medium_list) + 1)))

feature_columns = [embedded_content_column,
                   embedded_author_column,
                   embedded_title_column,
                   crossed_months_since_medium_column,
                   medium_column] 
```
<br>
## 2. Create the input function.
Next we'll create the input function for our model. This input function reads the data from the csv files we created in the previous labs.

```python
record_defaults = [["Unknown"],["Unknown"],["Unknown"],["Unknown"],["Unknown"],["Unknown"],["Unknown"],["Unknown"],["Unknown"],[mean_months_since_epoch],["Unknown"]]
column_keys = ["visitor_id", "content_id","medium","trafficSource","browser","region","screeResolution","title", "author", "months_since_epoch","next_content_id"]
label_key = "next_content_id"

def read_dataset(filename, mode, batch_size = 512):
  def _input_fn():
      def decode_csv(value_column):
          columns = tf.decode_csv(value_column,record_defaults=record_defaults)
          features = dict(zip(column_keys, columns))          
          label = features.pop(label_key)         
          return features, label

      # Create list of files that match pattern
      file_list = tf.gfile.Glob(filename)

      # Create dataset from file list
      dataset = tf.data.TextLineDataset(file_list).map(decode_csv)

      if mode == tf.estimator.ModeKeys.TRAIN:
          num_epochs = None # indefinitely
          dataset = dataset.shuffle(buffer_size = 10 * batch_size)
      else:
          num_epochs = 1 # end-of-input after this

      dataset = dataset.repeat(num_epochs).batch(batch_size)
      return dataset.make_one_shot_iterator().get_next()
  return _input_fn
  ```
  
## 3. Create the model and train/evaluate
Next, we'll build our model which recommends an article for a visitor to the journaldemontreal website.

```python
def model_fn(features, labels, mode, params):
  # `input_layer` applies the transformations defined by your feature columns, creating the model's input layer
  net = tf.feature_column.input_layer(features, params['feature_columns'])
  
#   tf.layers.dense create hidden layers
#   units parameter defines the number of output neurons
#   net = input layer 
  for units in params['hidden_units']:
        net = tf.layers.dense(net, units=units, activation=tf.nn.relu)
      
   # Compute logits (1 per class).
   # Here, net signifies the final hidden layer
    
  logits = tf.layers.dense(net, params['n_classes'], activation=None) 

  predicted_classes = tf.argmax(logits, 1)
  from tensorflow.python.lib.io import file_io
    
  with file_io.FileIO('content_ids.txt', mode='r') as ifp:
    content = tf.constant([x.rstrip() for x in ifp])
  predicted_class_names = tf.gather(content, predicted_classes)
  
#   Your model function must provide code to handle all three of the mode values (ModeKeys.PREDICT, ModeKeys.TRAIN, ModeKeys.EVAL)
#   For each mode value, your code must return an instance of tf.estimator.EstimatorSpec, which contains the information the caller requires
  
  if mode == tf.estimator.ModeKeys.PREDICT:
    predictions = {
        'class_ids': predicted_classes[:, tf.newaxis],
        'class_names' : predicted_class_names[:, tf.newaxis],
        'probabilities': tf.nn.softmax(logits),
        'logits': logits,
    }
    return tf.estimator.EstimatorSpec(mode, predictions=predictions)
  table = tf.contrib.lookup.index_table_from_file(vocabulary_file="content_ids.txt")
  labels = table.lookup(labels)
  
  # Compute loss.
  loss = tf.losses.sparse_softmax_cross_entropy(labels=labels, logits=logits)

  # Compute evaluation metrics.
  accuracy = tf.metrics.accuracy(labels=labels,
                                 predictions=predicted_classes,
                                 name='acc_op')
  top_5_accuracy = tf.metrics.mean(tf.nn.in_top_k(predictions=logits, targets=labels, k=5))
  
  metrics = {
    'accuracy': accuracy,
    'top_5_accuracy' : top_5_accuracy}
    
#   tf.summary.scalar make accuracy available to TensorBoard in both TRAIN and EVAL modes
  tf.summary.scalar('accuracy', accuracy[1])
  tf.summary.scalar('top_5_accuracy', top_5_accuracy[1])

  if mode == tf.estimator.ModeKeys.EVAL:
      return tf.estimator.EstimatorSpec(
          mode, loss=loss, eval_metric_ops=metrics)

  # Create training op.
  assert mode == tf.estimator.ModeKeys.TRAIN

  optimizer = tf.train.AdagradOptimizer(learning_rate=0.1)
  train_op = optimizer.minimize(loss, global_step=tf.train.get_global_step())
  return tf.estimator.EstimatorSpec(mode, loss=loss, train_op=train_op)
  ```
 <br>
   
## 4. Train and Evaluate
```python
tf.logging.set_verbosity(tf.logging.INFO)

outdir = 'content_based_model_trained_testJDMv12souscategories'
shutil.rmtree(outdir, ignore_errors = True)


estimator = tf.estimator.Estimator(
    model_fn=model_fn,
    model_dir = outdir,
    params={
     'feature_columns': feature_columns,
      'hidden_units': [200, 100, 50],
      'n_classes': len(content_ids_list)
    })

train_spec = tf.estimator.TrainSpec(
    input_fn = read_dataset("training_set.csv", tf.estimator.ModeKeys.TRAIN),
    max_steps = 800)

eval_spec = tf.estimator.EvalSpec(
    input_fn = read_dataset("test_set.csv", tf.estimator.ModeKeys.EVAL),
    steps = None,
    start_delay_secs = 30,
    throttle_secs = 60)

tf.estimator.train_and_evaluate(estimator, train_spec, eval_spec)
 ```
 
## 5. TensorBoard
We can monitor the performance of our training job using Tensorboard
```python
from google.datalab.ml import TensorBoard
TensorBoard().start('/<YOURPATH>')
 ```

