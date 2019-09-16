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
OUTPUT(raw);