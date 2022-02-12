"""
some useful functions
author: shiyanglai
email: shiyanglai@uchicago.edu
"""

import pandas as pd
import numpy as np


def read_data(folder_path='/Users/shiyang/Desktop/cryptocurrency/Exp Data/v2/', name='returns', binary=False):
    if name not in ['exchange', 'returns', 'preturns',
                    'nreturns', 'volatility']:
        raise ValueError
    data = pd.read_csv(folder_path + name + '.csv', index_col=0)
    if binary:
        data = data.applymap(lambda x: 1 if x > 0 else 0)
    return data


def series_to_supervised(data, n_in=1, n_out=1):
    """
    transform the raw dataset to lagged training dataset
    data: raw dataset
    n_in: number of days want to predict
    n_out: number of historical days want to use for prediction
    """
    n_vars = 1 if type(data) is list else data.shape[1]
    cols, names = list(), list()
    # input sequence (t-n ... t-1)
    for i in range(n_in, 0, -1):
        cols.append(data.shift(i))
        names += [f'{data.columns[j][3:]}(t-{i})' for j in range(n_vars)]
    # forecast sequence (t, t+1, ... t+n)
    for i in range(0, n_out):
        cols.append(data.shift(-i))
        if i == 0:
            names += [f'{data.columns[j][3:]}(t)' for j in range(n_vars)]
        else:
            names += [f'{data.columns[j][3:]}(t-{i})' for j in range(n_vars)]
    # put it all together
    agg = pd.concat(cols, axis=1)
    agg.columns = names
    # drop rows with NaN values
    agg.dropna(inplace=True)
    return agg