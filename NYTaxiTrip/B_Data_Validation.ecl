IMPORT NYTaxiTrip.A_Data_Ingestion;

//Reading Taxi_Weather Data
raw := A_Data_Ingestion.raw;

//Data Validation
validSet := raw( (INTEGER) date < 20000101 AND (INTEGER) date > 20190501 );
OUTPUT(validSet);
