"""
some useful functions
author: shiyanglai
email: shiyanglai@uchicago.edu
"""

import pandas as pd
import numpy as np


def read_data(folder_path='/Users/shiyang/Desktop/cryptocurrency/Exp Data/v2/', name='returns'):
    if name not in ['exchange', 'returns', 'preturns',
                    'nreturns', 'volatility']:
        raise ValueError
    return pd.read_csv(folder_path + name + '.csv', index_col=0)