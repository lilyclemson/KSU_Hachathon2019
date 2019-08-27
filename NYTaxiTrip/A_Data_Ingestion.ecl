IMPORT STD;

// Reading Taxi_Weather Data
EXPORT A_Data_Ingestion := MODULE

EXPORT Layout := RECORD
  STRING date;
  STRING precipintensity;
  STRING trip_counts;
END;

// Change the file name based on your username, workspace name and raw file name in below format:
// '~USERNMAE::WORKSPACENAME::RAWFILENAME'
// For example, if your usename is Mike and you created a worksplace 'HPCCSystems'.
// The raw file you uploaded is 'test.csv'.Then the file name inside the DATASET() function should be
//  '~Mike::HPCCSystems::test.csv'
EXPORT raw := DATASET('~Training::HPCCSystems::NY_SampleInput.csv', Layout, CSV(HEADING(1)));

END;