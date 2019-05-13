---
layout: post
title: Content-based recommendation system using neural networks - Part 3
---
<br>
<br>
In this post, we will build our content based model in the cloud. Train our model in the cloud will allow us to train on large amounts of data and without having to manage any infrastructure.
We will use Cloud ML Engine to train our content-based model DNN in TensorFlow.
In order to do this, we need to put our code into a Python package (i.e. add setup.py and __init__.py files) and we will organize our code into:
* model.py
* task.py
<br>
<br>
<br>
<img class="progressiveMedia-image js-progressiveMedia-image" data-src="https://cdn-images-1.medium.com/max/2400/1*2185PkdnkS-e-jNWGC3Hpw.png" src="https://cdn-images-1.medium.com/max/2400/1*2185PkdnkS-e-jNWGC3Hpw.png">
<br>
<br>
## 1. Submitting a job to ML Engine
task.py will be executed by ML Engine and it references our content-based model logic located in model.py.
<br>

```
import os
import tensorflow as tf
import numpy as np
import google.datalab.bigquery as bq

PROJECT = 'PROJECT' # REPLACE WITH YOUR PROJECT ID
BUCKET = 'BUCKET' # REPLACE WITH YOUR BUCKET NAME
REGION = 'us-central1' # REPLACE WITH YOUR BUCKET REGION e.g. us-central1

# do not change these
os.environ['PROJECT'] = PROJECT
os.environ['BUCKET'] = BUCKET
os.environ['REGION'] = REGION
os.environ['TFVERSION'] = '1.8'


gcloud  config  set project $PROJECT
gcloud config set compute/region $REGION
```

<br>
<br>
### model.py
<br>
```
#!/usr/bin/env python
# coding=utf-8

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

# Import helpful libraries and setup our project, bucket, and region
import tensorflow as tf
import tensorflow_hub as hub
from tensorflow.python.lib.io import file_io


# tensorboard==1.8.0
# tensorflow==1.8.0
# tensorflow-hub==0.2.0


import os
import tensorflow as tf
import numpy as np
import tensorflow_hub as hub
import shutil



def build_model(args):


# Variable pour serving_input_fn()
    NON_FACTOR_COLUMNS = 'next_content_id,visitor_id,content_id,category,title,author,months_since_epoch'.split(',')


    record_defaults = [["Unknown"], ["Unknown"],["Unknown"],["Unknown"],["Unknown"],[523],["Unknown"]]


    column_keys = ["visitor_id", "content_id", "category", "title", "author", "months_since_epoch", "next_content_id"]
    label_key = "next_content_id"

    def read_dataset(filename, mode, batch_size = 512):
      def _input_fn():
          def decode_csv(value_column):
              columns = tf.decode_csv(value_column,record_defaults=record_defaults)
    #           columns = tf.decode_csv(value_column,record_defaults=record_defaults, use_quote_delim=False)
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


    def create_feature_columns(args):

      embedded_title_column = hub.text_embedding_column(key="title", module_spec="https://tfhub.dev/google/nnlm-de-dim50/1", trainable=False)
        #test
        # title_column = tf.feature_column.categorical_column_with_hash_bucket(key="title",
        #     hash_bucket_size=len(content_ids_list) + 1)
        # embedded_title_column = tf.feature_column.embedding_column(
        #     categorical_column=title_column,
        #     dimension=10)

      content_id_column = tf.feature_column.categorical_column_with_hash_bucket(
            key="content_id",



            hash_bucket_size= 6088 + 1)

      embedded_content_column = tf.feature_column.embedding_column(
            categorical_column=content_id_column,
            dimension=10)

      author_column = tf.feature_column.categorical_column_with_hash_bucket(key="author",



            hash_bucket_size=459 + 1)







      embedded_author_column = tf.feature_column.embedding_column(
            categorical_column=author_column,
            dimension=3)

      category_column_categorical = tf.feature_column.categorical_column_with_vocabulary_list(
            key="category",
            vocabulary_list=['Facebook Instant Articles','Le sac de chips''ActualitÃ©','Opinions''Argent','EnquÃªtes','Monde','Spectacles','24heures','Sports','JM','Blogues','Weekend','Le Guide de l\'auto','Porte-monnaie','Voyages','DÃ©cÃ¨s','En 5 minutes','publireportage','Qub Radio','Automatisation','Magasiner'],
            num_oov_buckets=1)

      # category_column_categorical = tf.feature_column.categorical_column_with_vocabulary_file(key = "category", vocabulary_file = tf.gfile.Glob(filename = "gs://numericanalytics/contentbased_dnn/labs/categories.txt"), num_oov_buckets = 1)


      category_column = tf.feature_column.indicator_column(category_column_categorical)

      months_since_epoch_boundaries = list(range(400,700,20))
      months_since_epoch_column = tf.feature_column.numeric_column(
            key="months_since_epoch")
      months_since_epoch_bucketized = tf.feature_column.bucketized_column(
            source_column = months_since_epoch_column,
            boundaries = months_since_epoch_boundaries)

      crossed_months_since_category_column = tf.feature_column.indicator_column(tf.feature_column.crossed_column(
          keys = [category_column_categorical, months_since_epoch_bucketized],





          hash_bucket_size = 330 + 1))









      feature_columns = [embedded_content_column,
                           embedded_author_column,
                           category_column,
                           embedded_title_column,
                           crossed_months_since_category_column]

      return feature_columns




    def model_fn(features, labels, mode, params):
      net = tf.feature_column.input_layer(features, params['feature_columns'])

      for units in params['hidden_units']:
                net = tf.layers.dense(net, units=units, activation=tf.nn.relu)

      logits = tf.layers.dense(net, params['n_classes'], activation=None)

      predicted_classes = tf.argmax(logits, 1)
      values, predicted_test = tf.nn.top_k(logits, 3)

 
    
    


      from tensorflow.python.lib.io import file_io

      with file_io.FileIO("gs://numericanalytics/contentbased_dnn/labs/content_ids.txt", mode = 'r') as ifp:
            content = tf.constant([x.rstrip() for x in ifp])

        # Gather predicted class names based predicted class indices
      predicted_class_names = tf.gather(content, predicted_classes)
      predicted_class_test = tf.gather(content, predicted_test)


      if mode == tf.estimator.ModeKeys.PREDICT:
         predictions = {'class_ids': predicted_classes[:, tf.newaxis], 'class_names' : predicted_class_names[:, tf.newaxis], 'probabilities': tf.nn.softmax(logits), 'logits': logits, 'class_test' : predicted_class_test[:, tf.newaxis]}
#          predictions = {'class_names' : predicted_class_names[:, tf.newaxis]}


            # Create export outputs
         export_outputs = {"predict_export_outputs": tf.estimator.export.PredictOutput(outputs = predictions)}

         return tf.estimator.EstimatorSpec( # return early since we're done with what we need for prediction mode
                mode = mode,
                predictions = predictions,
                loss = None,
                train_op = None,
                eval_metric_ops = None,
                export_outputs = export_outputs)



      table = tf.contrib.lookup.index_table_from_file(vocabulary_file = "gs://numericanalytics/contentbased_dnn/labs/content_ids.txt")
      labels = table.lookup(labels)

          # Compute loss.
      loss = tf.losses.sparse_softmax_cross_entropy(labels=labels, logits=logits)

          # Compute evaluation metrics.
      accuracy = tf.metrics.accuracy(labels=labels, predictions=predicted_classes, name='acc_op')
      top_10_accuracy = tf.metrics.mean(tf.nn.in_top_k(predictions=logits, targets=labels, k=10))

      metrics = {
            'accuracy': accuracy,
            'top_10_accuracy' : top_10_accuracy}

        #   tf.summary.scalar make accuracy available to TensorBoard in both TRAIN and EVAL modes
      tf.summary.scalar('accuracy', accuracy[1])
      tf.summary.scalar('top_10_accuracy', top_10_accuracy[1])



      if mode == tf.estimator.ModeKeys.EVAL:
        # return tf.estimator.EstimatorSpec(mode, loss=loss, eval_metric_ops=metrics)
        return tf.estimator.EstimatorSpec( # return early since we're done with what we need for evaluation mode
                mode = mode,
                predictions = None,
                loss = loss,
                train_op = None,
                eval_metric_ops = metrics,
                export_outputs = None)



          # Create training op.
      assert mode == tf.estimator.ModeKeys.TRAIN

      optimizer = tf.train.AdagradOptimizer(learning_rate = params['learning_rate'])
      train_op = optimizer.minimize(loss, global_step=tf.train.get_global_step())
      return tf.estimator.EstimatorSpec( # final return since we're done with what we need for training mode
            mode = mode,
            predictions = None,
            loss = loss,
            train_op = train_op,
            eval_metric_ops = None,
            export_outputs = None)


    # The serving_input_fn function is used to define the shapes and types of the inputs the model accepts when the model is exported
    # It is optional, but required for deploying the trained model to a endpoint

    def serving_input_fn():
      # Logic to the following:
      # 1. Defines placeholders that TensorFlow will feed with inference requests
      # 2. Preprocess input data
      # 3. Returns a tf.estimator.export.ServingInputReceiver or tf.estimator.export.TensorServingInputReceiver,
      # which packages the placeholders and the resulting feature Tensors together.
        feature_placeholders = {
            colname : tf.placeholder(dtype = tf.string, shape = [None]) \
            for colname in NON_FACTOR_COLUMNS[1:-1]
        }
        feature_placeholders['months_since_epoch'] = tf.placeholder(dtype = tf.float32, shape = [None])

        features = {
            key: tf.expand_dims(tensor, -1) \
            for key, tensor in feature_placeholders.items()
        }

        return tf.estimator.export.ServingInputReceiver(features, feature_placeholders)


    # Create train and evaluate loop to combine all of the pieces together.
    tf.logging.set_verbosity(tf.logging.INFO)
    def train_and_evaluate(args):
      estimator = tf.estimator.Estimator(
            model_fn=model_fn,
            model_dir = args['output_dir'],
            params={
              'feature_columns': create_feature_columns(args),
              'hidden_units': [200, 100, 50],
              'bucket': args['bucket'],




              'n_classes': 6088,






              'learning_rate': args['learning_rate'],
            })





      train_spec = tf.estimator.TrainSpec(
            input_fn = read_dataset(filename = args['train_data_paths'], mode = tf.estimator.ModeKeys.TRAIN, batch_size = args['batch_size']), max_steps = args['train_steps'])



      exporter = tf.estimator.LatestExporter('exporter', serving_input_fn)



      eval_spec = tf.estimator.EvalSpec(
            input_fn = read_dataset(filename = args['eval_data_paths'], mode = tf.estimator.ModeKeys.EVAL, batch_size = args['batch_size']),
            steps = None,
            start_delay_secs = args['start_delay_secs'],
            throttle_secs = args['throttle_secs'],
            exporters = exporter)








      tf.estimator.train_and_evaluate(estimator, train_spec, eval_spec)


    # Call train_and_evaluate loop
    train_and_evaluate(args)
```


<br>
<br>
### task.py
<br>

```
import argparse
import json
import os
import shutil

from . import model

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    # Input and output paths
    parser.add_argument(
        '--bucket',
        help = 'GCS path to training data',
        required = True
    )
    parser.add_argument(
        '--train_data_paths',
        help = 'GCS path to training data',
        required = True
    )
    parser.add_argument(
        '--eval_data_paths',
        help = 'GCS path to validation data',
        required = True
    )
    parser.add_argument(
        '--output_dir',
        help = 'GCS pat to write checkpoints and export models',
        required = True
    )
    # Tunable hyperparameters
    parser.add_argument(
        '--batch_size',
        help = 'The number of examples in each mini-batch',
        type = int,
        default = 512
    )
    parser.add_argument(
        '--learning_rate',
        help = 'The learning rate for gradient descent',
        type = float,
        default = 0.1
    )
    parser.add_argument(
        '--hidden_units',
        help = 'Hidden layer sizes to use for DNN feature columns -- provide space-separated layers',
        type = str,
        default = "200 100 50"
    )
    parser.add_argument(
        '--train_steps',
        help = 'The number of steps/batches to train on',
        type = int,
        default = 2000
    )
    parser.add_argument(
        '--start_delay_secs',
        help = 'The number of seconds to delay before starting evaluation',
        type = int,
        default = 30
    )
    parser.add_argument(
        '--throttle_secs',
        help = 'The number of seconds between each evaluation',
        type = int,
        default = 60
    )
    parser.add_argument(
        '--job-dir',
        help = 'this model ignores this field, but it is required by gcloud',
        default = 'junk'
    )

    args = parser.parse_args()
    arguments = args.__dict__

    # unused args provided by service
    arguments.pop('job_dir', None)
    arguments.pop('job-dir', None)

    # Create hidden_units list
    arguments['hidden_units'] = [int(x) for x in arguments['hidden_units'].split(" ")]

    # Append trial_id to path if we are doing hptuning
    # This code can be removed if you are not using hyperparameter tuning
    arguments['output_dir'] = os.path.join(
        arguments['output_dir'],
        json.loads(
            os.environ.get('TF_CONFIG', '{}')
        ).get('task', {}).get('trial', '')
    )

    # Run the training job
    shutil.rmtree(arguments['output_dir'], ignore_errors = True) # start fresh each time
    model.build_model(arguments)


```
<br>
### Run on Google Cloud ML Engine with Cloud Datalab in GCP
```
%bash
OUTDIR=gs://${BUCKET}/contentbased_dnn/labs/small_trained_model
JOBNAME=contentbased_recommendation_$(date -u +%y%m%d_%H%M%S)
echo $OUTDIR $REGION $JOBNAME
gsutil -m rm -rf $OUTDIR
gcloud ml-engine jobs submit training $JOBNAME \
  --region=$REGION \
  --module-name=trainer.task \
  --package-path=$(pwd)/trainer \
  --job-dir=$OUTDIR \
  --staging-bucket=gs://$BUCKET \
  --scale-tier=BASIC_GPU \
  --runtime-version=$TFVERSION \
  -- \
  --bucket=${BUCKET} \
  --train_data_paths=gs://${BUCKET}/contentbased_dnn/labs/training_set.csv* \
  --eval_data_paths=gs://${BUCKET}/contentbased_dnn/labs/test_set.csv* \
  --output_dir=${OUTDIR} \
  --batch_size=128 \
  --learning_rate=0.1 \
  --hidden_units="256 128 64" \
  --train_steps=1000 \
  --start_delay_secs=30 \
  --throttle_secs=30
```

### TensorBoard
```
from google.datalab.ml import TensorBoard
TensorBoard().start('gs://numericanalytics/contentbased_dnn/labs/small_trained_model')
```

```
for pid in TensorBoard.list()['pid']:
  TensorBoard().stop(pid)
  print("Stopped TensorBoard with pid {}".format(pid))
```
### Create model & version on Cloud ML Engine
```
%bash
MODEL_NAME="Contentbased_DNN_test_top3"
MODEL_VERSION="ml_on_gcp"
MODEL_LOCATION=$(gsutil ls gs://numericanalytics/contentbased_dnn/labs/small_trained_model/export/exporter/ | tail -1)
echo "Deleting and deploying $MODEL_NAME $MODEL_VERSION from $MODEL_LOCATION ... this will take a few minutes"
#gcloud ml-engine versions delete ${MODEL_VERSION} --model ${MODEL_NAME}
#gcloud ml-engine models delete ${MODEL_NAME}
gcloud ml-engine models create ${MODEL_NAME} --regions $REGION
gcloud ml-engine versions create ${MODEL_VERSION} --model ${MODEL_NAME} --origin ${MODEL_LOCATION} --runtime-version $TFVERSION
```

### Make Predictions
```
%bash
OUTDIR=gs://${BUCKET}/contentbased_dnn/labs/small_trained_model
JOBNAME=contentbased_recommendation_$(date -u +%y%m%d_%H%M%S)
MODEL_NAME="Contentbased_DNN_test"
MODEL_VERSION="ml_on_gcp"

from oauth2client.client import GoogleCredentials
import requests
import json

MODEL_NAME = 'Contentbased_DNN_test_top3'
MODEL_VERSION = 'ml_on_gcp'

token = GoogleCredentials.get_application_default().get_access_token().access_token
api = 'https://ml.googleapis.com/v1/projects/{}/models/{}/versions/{}:predict' \
         .format(PROJECT, MODEL_NAME, MODEL_VERSION)
headers = {'Authorization': 'Bearer ' + token }
data = {
  'instances': [
    {
      'visitor_id': '1000056146838977869',
      'content_id': '/2018/12/10/un-olivier-dans-la-gorge',
      'category': 'Opinions',
      'title': 'Un Olivier dans la gorge',
      'author': 'Sophie Durocher',
      'months_since_epoch': 540
    },
  ]
}
response = requests.post(api, json=data, headers=headers)
print(response.content)
```
