# hp Assignment
List of components used - 

**Custom Object** _Vaccination Center_ - To store the vaccination center locations                                                                                                 **LWC component** _vaccinationDetails_ - To display list of people based on nearest vaccination center
**Apex class**
    _People.cls - _Wrapper class to store people data from JSON file
    _CovidUtility.cls - _Class to prpare Map which will store <Vaccination Center => Nearest people list sorted by Age>
    _CovidUtilityTest.cls -_ Unit test to cover the funcationality of CovidUtility class
    
**Static Resource** - _PeopleJSON_ file to store the JSON Data

The function can be tested by adding vaccinationDetails to Home Page Component.
