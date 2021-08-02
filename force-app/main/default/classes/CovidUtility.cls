public with sharing class CovidUtility {
   
    @testVisible
    private static final String peopleDataJsonFileName = 'PeopleJSON';
    private static final String DISTANC_EPARAM_MI = 'mi';
    public static List<Vaccination_Center__c> mockVaccCenterData;

    public class VaccinationCenterDetail{
        @AuraEnabled
        public string centerName{get;set;}
        @AuraEnabled
        public List<People> peopleList{get;set;}
    }

    // Method to prepare the map to store <Nearest Vaccination Center, Sorted People List based on age and location>
    @AuraEnabled(cacheable=true)
    public static map<string, List<People>> getPeopleWithVaccinationCenter(){
        List<People> peopleList =  CovidUtility.getPeopleList();
        List<Vaccination_Center__c> centerList =  CovidUtility.getCenterList();
        map<string, List<People>> centerPeopleMap = new map<string, List<People>>();

        List<People> pList;
        for(People peopleObj : peopleList){
            CovidUtility.getNearestCenter(peopleObj, centerList);
            
            if(centerPeopleMap.get(peopleObj.nearestCenter) != null){
                pList = centerPeopleMap.get(peopleObj.nearestCenter);
            }
            else {
                pList = new List<People>();
            }
            pList.add(peopleObj);
            centerPeopleMap.put(peopleObj.nearestCenter, pList);
        }
        return centerPeopleMap;
    }

    // Method to find the list of vaccination center available in database
    static List<Vaccination_Center__c> getCenterList(){
        return [Select Id, Name, location__c From Vaccination_Center__c];
    }

    // Method to get people list data from static resource
    static List<People> getPeopleList(){
        StaticResource peopleJSONData = [select id,body from StaticResource Where Name =: peopleDataJsonFileName];
        String allcontents = peopleJSONData.body.toString();

        List<People> peopleList =  (List<People>)People.parse(allcontents);
        return peopleList;
    }

    // Method to find nearest vaccination center among list of available center list
    static void getNearestCenter(People p, List<Vaccination_Center__c> centerList){
        map<double, string> distanceCenterMap = new map<double, string>();
        List<double> distanceList = new List<double>();
        for(Vaccination_Center__c center : centerList){
            Double distance =  CovidUtility.getDistance(p,center.location__c);
           
            distanceList.add(distance);
            distanceCenterMap.put(distance, center.Name);
        }
        distanceList.sort();        
       
        p.nearestCenter =  distanceCenterMap.get(distanceList[0]);
    }

    // Method to get distance between people and vaccination center in Miles
    static Double getDistance(People p, Location centerLoc){
        Location personLoc = Location.newInstance(decimal.valueOf(p.latitude) ,decimal.valueOf(p.longitude) );
        return Location.getDistance(personLoc, centerLoc, DISTANC_EPARAM_MI);
    }
}
