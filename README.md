# hp Assignment
List of components used - 

Custom Object - Vaccination Center - To store the vaccination center locations
LWC component -  vaccinationDetails - To display list of people based on nearest vaccination center
Apex class - 
    People.cls - Wrapper class to store people data from JSON file
    CovidUtility.cls - Class to prpare Map which will store <Vaccination Center => Nearest people list sorted by Age>
    CovidUtilityTest.cls - Unit test to cover the funcationality of CovidUtility class
    
Static Resource - PeopleJSON file to store the JSON Data

The function can be tested by adding vaccinationDetails to Home Page Component.
