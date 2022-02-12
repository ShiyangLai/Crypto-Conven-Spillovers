"""
prediction tasks and models
author: shiyanglai
email: shiyanglai@uchicago.edu
"""

import numpy as np
import pandas as pd
from utils import read_data, series_to_supervised


def seq2seq_X_y(data, feature_num, i, lag, look_back, step_ahead):
    train_X = data[(i-look_back):i, :-step_ahead].reshape((look_back, lag, feature_num))
    train_y = data[(i-look_back):i, -step_ahead:]
    test_X = data[i:(i+1), :-step_ahead].reshape((1, lag, feature_num))
    test_y = data[i:(i+1), -step_ahead:]
    return train_X, test_X, train_y, test_y


def simple_X_y(data, feature_num, i, look_back, step_ahead):
    train_X = data[(i-look_back):i, :-step_ahead]
    train_y = data[(i-look_back):i, -step_ahead:]
    test_X = data[i:(i+1), :-step_ahead]
    test_y = data[i:(i+1), -step_ahead:]
    return train_X, test_X, train_y, test_y


def binary_task(dataset, focal, in_system, model, horizion=1, lookback=1826, lag=7):
    # for comparasion purpose, I do the training on the whole dataset and the in_system dataset
    whole_dataset = dataset.copy()
    feature_num = whole_dataset.shape[1]
    # convert the format of the dataset, using historiy datapoints to predict n step ahead 
    whole_dataset = series_to_supervised(whole_dataset, n_in=lag, n_out=horizion)
    drop = [col[3:] + '(t)' for col in dataset.columns if col[3:] != focal]
    whole_dataset.drop(columns=drop, axis=1, inplace=True)
    whole_dataset = whole_dataset.values
    
    # using a rolling window to test the performance of the model
    real = []
    predicted_all = []
    for i in range(lookback, whole_dataset.shape[0], horizion):
        train_X, test_X, train_y, test_y = simple_X_y(whole_dataset, feature_num, i, lookback, horizion)
        trained_model = model.fit(train_X, train_y)
        real.append(test_y[0])
        predicted_all.append(trained_model.predict(test_X)[0])
    
    in_sys_dataset = dataset[in_system]
    in_sys_dataset = series_to_supervised(in_sys_dataset, n_in=lag, n_out=horizion)
    drop = [col[3:] + '(t)' for col in in_system if col[3:] != focal]
    in_sys_dataset.drop(columns=drop, axis=1, inplace=True)
    in_sys_dataset = in_sys_dataset.values
    
    predicted_part = []
    for i in range(lookback, in_sys_dataset.shape[0], horizion):
        train_X, test_X, train_y, test_y = simple_X_y(in_sys_dataset, feature_num, i, lookback, horizion)
        trained_model = model.fit(train_X, train_y)
        predicted_part.append(trained_model.predict(test_X)[0])
        
    print('Trained successfully!')
    return predicted_all, predicted_part, real
