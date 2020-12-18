from numpy import loadtxt
import numpy as np
from keras.models import Sequential
from keras.layers import Dense, Activation
from keras.wrappers.scikit_learn import KerasRegressor
from sklearn.model_selection import cross_val_score, cross_val_predict
from sklearn.model_selection import KFold
from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import Pipeline

import matplotlib.pyplot as plt
from sklearn.model_selection import GridSearchCV
from keras.optimizers import SGD
from keras.constraints import maxnorm

from sklearn.preprocessing import MinMaxScaler
import csv
import pandas as pd
from sklearn.metrics import mean_squared_error
from scipy.stats import zscore
import sklearn
print(sklearn.__version__)

from scipy.stats import spearmanr
from numpy.random import seed
seed(1)
from tensorflow import set_random_seed
set_random_seed(2)

dataset = pd.read_excel('datosUnicos.xlsx', usecols=  "A:H")
dataset = np.asarray(dataset)
x = dataset[:,0:6]
y = dataset[:,6]
nit = dataset[:,7]
#nit2 = dataset[:,]
#print(nit2)

# Cross-Validate
kf = KFold(5, shuffle=True, random_state=42) # Use for KFold classification
    
oos_y = []
oos_pred = []

def rmse(predicts, targets): 
  return np.sqrt(((predicts - targets) ** 2).mean())

def corr(predicts, targets, nit):
  a = predicts - np.mean(predicts)
  b = nit - np.mean(nit)
  return sum(a*b) / (np.sqrt(sum(a**2))*(np.sqrt(sum(b**2))))

def main():
  fold = 0
  for train, test in kf.split(x):
    fold+=1
    print("Fold %f", fold)
    x_train = x[train]
    y_train = y[train]
    x_test = x[test]
    y_test = y[test]
    
    model = Sequential()
    model.add(Dense(20, input_dim=6, activation='relu'))
    model.add(Dense(10, activation='relu'))
    model.add(Dense(1))
    model.compile(loss='mean_squared_error', optimizer='adam')
    model.fit(x_train, y_train, validation_data=(x_test,y_test), verbose=0, epochs=500)    
    pred = model.predict(x_test)
   
    oos_y.append(y_test)
    oos_pred.append(pred)    

    # Measure this fold's RMSE
    score = np.sqrt(metrics.mean_squared_error(pred,y_test))
    print("Fold score (RMSE):", score)

  # Build the oos prediction list and calculate the error.
  oos_y = np.concatenate(oos_y)
  oos_pred = np.concatenate(oos_pred)
  score = np.sqrt(metrics.mean_squared_error(oos_pred,oos_y))
  print("Final, out of sample score (RMSE):", score)    
    
  # Write the cross-validated prediction
  oos_y = pd.DataFrame(oos_y)
  oos_pred = pd.DataFrame(oos_pred)
  oosDF = pd.concat( [df, oos_y, oos_pred],axis=1 )
  #oosDF.to_csv(filename_write,index=False)


  for i in range(len(y_pred)):
    print(y_pred[i])

  for i in range(len(y_pred)):
    print('%s => %f (expected %f)' % (X_test[i].tolist(), y_pred[i], Y_test[i]))

  print('Root mean squared error %.3f' % rmse(y_pred, Y_test))
  coef, p = spearmanr(y_pred, nit)
  print('Spearmans correlation coefficient NT 2006: %.3f' % coef)

  #coef, p = spearmanr(y_pred, nit2)
  #print('Spearmans correlation coefficient NT 2010: %.3f' % coef)

  df= pd.DataFrame(y_pred)
  filepath = 'file.xlsx'
  df.to_excel(filepath, index=False)

  fig,ax = plt.subplots()
  ax.scatter(Y, y_pred)
  ax.plot([Y.min(), Y.max()], [Y.min(), Y.max()], 'k--', lw=2)
  ax.set_xlabel('Measured')
  ax.set_ylabel('Predicted')
  fig.show()

if __name__ == "__main__":
  main()