IMPORT ML_Core;
IMPORT ML_Core.Types;
IMPORT NYTaxiTrip.D_Data_Enhancement;
IMPORT LinearRegression AS LROLS;

//Reading enhanced data
enhancedData := D_Data_Enhancement.enhancedData;
OUTPUT(enhancedData, NAMED('enhancedData'));

//Transform to Machine Learning Dataframe, such as NumericField
ML_Core.ToField(enhancedData, trainset);
OUTPUT(trainset, NAMED('trainset'));

// split into input (X) and output (Y) variables
X := trainset(number < 4);
Y := trainset(number = 4);
OUTPUT(X, NAMED('X'));
OUTPUT(Y, NAMED('Y'));

//Training LinearRegression Model
lr := LROLS.OLS(X, Y);

//Prediction
predict := lr.predict(X);
OUTPUT(predict, NAMED('predict'));
