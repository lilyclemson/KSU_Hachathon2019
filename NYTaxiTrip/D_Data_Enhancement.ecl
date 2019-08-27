IMPORT STD;
IMPORT NYTaxiTrip.A_Data_Ingestion;

EXPORT D_Data_Enhancement := MODULE

//Reading Taxi_Weather Data
SHARED raw := A_Data_Ingestion.raw;

//Enhance raw data
//Enhancement 1
EXPORT enhancedLayout1 := RECORD
  UNSIGNED4 date;
  REAL8 precipintensity;
  UNSIGNED3 trip_counts;
END;
EXPORT enhancedData1 := PROJECT(raw, TRANSFORM(enhancedLayout1,
                                                SELF.date := (INTEGER) LEFT.date,
                                                SELF.precipintensity := (REAL) LEFT.precipintensity,
                                                SELF.trip_counts := (INTEGER) LEFT.trip_counts));

//Enhancement 2
EXPORT enhancedLayout2 := RECORD
  UNSIGNED2 id;
  UNSIGNED2 month_of_year;
  UNSIGNED2 day_of_week;
  REAL8   precipintensity;
  UNSIGNED3 trip_counts;
END;
EXPORT enhancedData2 := PROJECT(enhancedData1, TRANSFORM(enhancedLayout2,
                                        SELF.id := COUNTER,
                                        SELF.day_of_week := (INTEGER) Std.Date.DayOfWeek(LEFT.date),
                                        SELF.month_of_year := (INTEGER) Std.Date.Month(LEFT.date),
                                        SELF.precipintensity := LEFT.precipintensity,
                                        SELF.trip_counts := LEFT.trip_counts));
EXPORT enhancedData := enhancedData2;
END;