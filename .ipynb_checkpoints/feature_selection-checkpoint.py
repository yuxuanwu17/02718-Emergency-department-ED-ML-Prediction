timport pandas as pd
import numpy as np
from sklearn.feature_selection import SelectKBest, mutual_info_classif
from sklearn.model_selection import train_test_split
import time

np.random.seed(33)
df = pd.read_csv("data/Cleaned_dat_encoded.csv")
Y = df["disposition"]
X = df.drop("disposition", axis=1)

start = time.time()
selector = SelectKBest(mutual_info_classif, k=20).fit(X, Y)
cols = selector.get_support(indices=True)
end = time.time()
print(cols)
print(end - start)
df = X.iloc[:, cols]  # [  1   2   4   5   6   8   9  10  11  15 137 335 352 357 358 364 366 367 375 381]
df["disposition"] = Y
print(df.shape)
print(df.columns)

df.to_csv("data/featureSelectedAllDataWithY.csv", index=False)
# cols = [1, 2, 4, 5, 6, 8, 9, 10, 11, 15, 137, 335, 352, 357, 358, 364, 366, 367, 375, 381]
# X = X.iloc[:100, :]
# Y = Y.iloc[:100]
# print(Y.shape)
# print(type(Y))
# print(X.shape)
# print(type(X))
