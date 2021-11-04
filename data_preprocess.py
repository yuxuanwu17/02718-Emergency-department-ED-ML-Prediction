import pandas as pd
import numpy as np

np.random.seed(33)

df = pd.read_csv("data/allOnlyTriage.csv")

df = df.drop("Unnamed: 0", axis=1)

# print(df.head(6))
