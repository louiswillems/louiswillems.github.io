---
layout: page
title: Qu'aurait dit le général de Gaulle ? (Text Generation with FastAi & De Gaulle)
---


<img height="400" width="700" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/fast-colab.JPG" src="/public/fast-colab.png">

In this post, we will train a language model with Fastai for a text generation task ([Notebook here](https://colab.research.google.com/drive/1fyfnrzCOXt_L7eNSvfqCnGVqmR6N3xQt)).

This is an implementation of the ULMFit model (Universal Language Model Fine-tuning for Text Classification) on French language.
We will use an AWD-LSTM architecture trained on 100 million words corpus, composed of an extract of Wikipedia in French.
In order to generate specific text, we will fine-tuned a model with Charles de Gaulle’s official speeches from 1940 to 1968.
Then, we will try to predict future speeches.

But first, who is Charles de Gaulle ? and why am I doing this ?

Charles de Gaulle was a French army officer and statesman who led the French Resistance against Nazi Germany in World War II ([here](https://www.wikiwand.com/en/Charles_de_Gaulle)).
Being passionate about French political debates, I often hear quotes from some politicians, who to confirm their ideas refer to Charles de Gaulle. But often those quotes are out of context
and some are even fake. So, my motivation here consists to train a model and try to predict what De Gaulle could have said on a particular subject.

You can find the data [here](http://www.charles-de-gaulle.org/lhomme/les-discours/) and download the pretrained weights and vocab [here](https://github.com/tchambon/deepfrench)

<br>

1. Download Data
2. Data Preparation & Fine-tuning
3. Results

<br>

*Note: the AWD-LSTM architecture used for our french language model can be sufficient to fine-tune another language model to do new tasks (like classification of positives or negatives reviews).
But, it is not sufficient to create and train an efficient text generation model. So, our model will not be as good as the generated text from OpenAI (GTP-2) but it will generates text that most of the time will makes sense in small sentences.*


Before we get the data and start exploring it, let's download all the dependencies that we will need:

```python
%reload_ext autoreload
%autoreload 2
%matplotlib inline

from fastai import *
from fastai.text import *
import pandas as pd

# Imprting files from Google Drive
from google.colab import drive
drive.mount('/content/drive')
```
<br>

## 1. Download Data

First let's download the dataset that has been extracted from [here](http://www.charles-de-gaulle.org/lhomme/les-discours/) and contains all official spechees from 1940 to 1968.  

```python
pd.read_csv('/content/drive/My Drive/DeepFrench/discours_degaulle.csv').head()
```
<br>
<br>

## 2. Data Preparation & Fine-tuning French LM

```python
tokenizer = Tokenizer(lang='fr', n_cpus=5)

data_lm = (TextLMDataBunch.from_csv('/content/drive/My Drive/DeepFrench/', tokenizer=tokenizer, csv_name='discours_degaulle.csv', text_cols=0, bs=32))
data_lm.show_batch()
```
To use the pre-trained LM, we have to load two files:

- Weights of the pretrained LM (wref30k)
- Mapping of the vocabulary of the pretrained model (itosref30k)

This will enable the Learner to load the weights of the pretrained model and to map the vocabulary of the new data with the data used for pretraining.

```python
weights = '/content/drive/My Drive/DeepFrench/wref30k'
itos = '/content/drive/My Drive/DeepFrench/itosref30k'
lm_fns = [weights, itos]

# Use of "n_hid" for old size
config = awd_lstm_lm_config.copy()
config['n_hid'] = 1150

learn_lm = language_model_learner(data_lm, AWD_LSTM, config=config, pretrained_fnames=lm_fns, drop_mult=0.3)

learn_lm.lr_find()
learn_lm.recorder.plot(skip_start=0)
```

```python
learn_lm.fit_one_cycle(1, 1e-3)
```

```python
learn_lm.unfreeze()
learn_lm.fit_one_cycle(2, 1e-3, moms=(0.8,0.7))
```
<br>
<br>

## 3. Results

```python
# Lowering temperature will make the texts less randomized.
TEXT = "la France"
N_WORDS = 40
N_SENTENCES = 1

print("\n".join(learn_lm.predict(TEXT, N_WORDS, temperature=0.50) for _ in range(N_SENTENCES)))
```
*"la France . le , les deux pays , en proie à une guerre civile , se sont alliés à la de la conférence de la paix . la conférence de paris de la conférence de londres"*

<br>

```python
# Lowering temperature will make the texts less randomized.
TEXT = "le peuple francais"
N_WORDS = 40
N_SENTENCES = 1

print("\n".join(learn_lm.predict(TEXT, N_WORDS, temperature=0.50) for _ in range(N_SENTENCES)))
```
*"le peuple francais de l' empire . le roi , nouveau chef de l' état , a décidé de donner à la république un statut de base pour la défense"*

