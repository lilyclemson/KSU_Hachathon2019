IMPORT Visualizer;

//Read raw data from HPCC Systems cluster

Layout := RECORD
    STRING number_of_rooms;
    STRING assessment_date;
    STRING beginning_point;
    STRING book_and_page;
    STRING building_code;
    STRING building_code_description;
    STRING category_code;
    STRING category_code_description;
    STRING census_tract;
    STRING central_air;
    STRING cross_reference;
    STRING date_exterior_condition;
    STRING depth;
    STRING exempt_building;
    STRING exempt_land;
    STRING exterior_condition;
    STRING fireplaces;
    STRING frontage;
    STRING fuel;
    STRING garage_spaces;
    STRING garage_type;
    STRING general_construction;
    STRING geographic_ward;
    STRING homestead_exemption;
    STRING house_extension;
    STRING house_number;
    STRING interior_condition;
    STRING location;
    STRING mailing_address_1;
    STRING mailing_address_2;
    STRING mailing_care_of;
    STRING mailing_city_state;
    STRING mailing_street;
    STRING mailing_zip;
    STRING market_value;
    STRING market_value_date;
    STRING number_of_bathrooms;
    STRING number_of_bedrooms;
    STRING basements;
    STRING number_stories;
    STRING off_street_open;
    STRING other_building;
    STRING owner_1;
    STRING owner_2;
    STRING parcel_number;
    STRING parcel_shape;
    STRING quality_grade;
    STRING recording_date;
    STRING registry_number;
    STRING sale_date;
    STRING sale_price;
    STRING separate_utilities;
    STRING sewer;
    STRING site_type;
    STRING state_code;
    STRING street_code;
    STRING street_designation;
    STRING street_direction;
    STRING street_name;
    STRING suffix;
    STRING taxable_building;
    STRING taxable_land;
    STRING topography;
    STRING total_area;
    STRING total_livable_area;
    STRING type_heater;
    STRING unfinished;
    STRING unit;
    STRING utility;
    STRING view_type;
    STRING year_built;
    STRING year_built_estimate;
    STRING zip_code;
    STRING zoning;
    STRING objectid;
    STRING lat;
    STRING lng;
END;

// Change the file name based on your username, workspace name and raw file name in below format:
// '~USERNMAE::WORKSPACENAME::RAWFILENAME'
// For example, if your usename is Mike and you created a worksplace 'HPCCSystems'.
// The raw file you uploaded is 'test.csv'.Then the file name inside the DATASET() function should be
//  '~Mike::HPCCSystems::test.csv'
raw := DATASET('~Training::HPCCSystems::sample10000.csv', Layout, CSV(HEADING(1)));


// Create the visualization, giving the count of multi-family vs single-family and supplying the result name "housing_viz"
housing_viz := TABLE(raw(category_code_description = 'Single Family' or category_code_description = 'Multi Family'),
                                              {category_code_description, cnt := COUNT(GROUP)}, category_code_description, MERGE);
OUTPUT(housing_viz, NAMED('housing_viz'));
Visualizer.TwoD.Pie('pieChart', /*datasource*/, 'housing_viz', /*mappings*/, /*filteredBy*/, /*dermatologyProperties*/ );


//Clean zip_code for visualization
Layout1 := RECORD(Layout)
  STRING zip9;
  STRING zip5;
  STRING zip4;
END;

searchpattern := '^[0-9]{9}$';
Layout1 splitZipTran(Layout l) := TRANSFORM
  last1 := LENGTH(l.zip_code);
  last4 := last1 - 4;
  z5 := l.zip_code[1..5];
  z4 := l.zip_code[last4..last1];
  SELF.zip5 := z5;
  SELF.zip4 := z4;
  SELF.zip9 := (z5 + z4);
  SELF := l;
END;
cleanZipCode := raw(REGEXFIND(searchpattern, zip_code));
splitZipDS := PROJECT(cleanZipCode, splitZipTran(LEFT));

// Create the visualization, giving the top 10 sales count by zip code and supplying the result name "sale_count_viz"
sale_count_viz := TABLE(splitZipDS, {zip9, cnt := COUNT(GROUP)}, zip9, MERGE);
OUTPUT(TOPN(sale_count_viz, 10, -cnt), NAMED('sale_count_viz'));
Visualizer.MultiD.column('barChart', /*datasource*/, 'sale_count_viz', /*mappings*/, /*filteredBy*/, /*dermatologyProperties*/ );

// Create the visualization, giving the top 10 sales count by zip code and supplying the result name "sale_count_viz"
sale_price_viz := TABLE(splitZipDS, {zip9, s := SUM(GROUP, (REAL)sale_price)}, zip9, MERGE);
OUTPUT(TOPN(sale_price_viz, 10, -s), NAMED('sale_price_viz'));
Visualizer.MultiD.column('barChart1', /*datasource*/, 'sale_price_viz', /*mappings*/, /*filteredBy*/, /*dermatologyProperties*/ );

// Create the visualization, giving the top 5 sales count by year and supplying the result name "year_viz"
year_viz := TABLE(raw( (UNSIGNED4)year_built >= 1900),{year_built, cnt := COUNT(GROUP)}, year_built, MERGE);
OUTPUT(TOPN(year_viz, 3 , -cnt), NAMED('year_viz'));
Visualizer.TwoD.Bubble('bubbleChart', /*datasource*/, 'year_viz', /*mappings*/, /*filteredBy*/, /*dermatologyProperties*/ );
