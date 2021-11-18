## Read the feature selected  data frame via mutual information

from sklearn.linear_model import LogisticRegression
from sklearn.metrics import confusion_matrix, accuracy_score
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split

import time


def logstic_regression(dir):
    np.random.seed(33)
    df = pd.read_csv(dir)

    training_data, testing_data = train_test_split(df, test_size=0.2, random_state=25)

    y_train = training_data['disposition']
    y_test = testing_data['disposition']
    X_train = StandardScaler().fit_transform(training_data.drop("disposition", axis=1))
    X_test = StandardScaler().fit_transform(testing_data.drop("disposition", axis=1))

    y_train = np.array(y_train)
    y_test = np.array(y_test)
    X_train = np.array(X_train)
    X_test = np.array(X_test)

    clf = LogisticRegression(random_state=0).fit(X_train, y_train)

    y_pred = clf.predict(X_test)

    mylist = []
    cm = confusion_matrix(y_test, y_pred)
    ac = accuracy_score(y_test, y_pred)
    mylist.append(ac)
    print(cm)
    print(ac)


if __name__ == '__main__':
    df = "data/featureSelectedAllDataWithY.csv"
    logstic_regression(df)
    # df = "data/Cleaned_dat_encoded.csv"
    # logstic_regression(df)
