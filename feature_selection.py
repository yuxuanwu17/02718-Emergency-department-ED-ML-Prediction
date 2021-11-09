import pandas as pd
import numpy as np
from sklearn.feature_selection import SelectKBest, mutual_info_classif
from sklearn.model_selection import train_test_split
import time

np.random.seed(33)
df = pd.read_csv("data/Cleaned_dat_encoded.csv")
X = df.iloc[:, :-1]
Y = df.iloc[:, -1]
start = time.time()
selector = SelectKBest(mutual_info_classif, k=20).fit(X, Y)
cols = selector.get_support(indices=True)
end = time.time()
print(cols)  # [ 2  4  5  6  8  9 10 12 22 23 26 45 47 49 53 59 60 63 64 68]
print(end - start)
df = df.iloc[:, cols]
print(df.shape)
print(df.columns)
df.to_csv("data/featureSelectedAllData.csv")
