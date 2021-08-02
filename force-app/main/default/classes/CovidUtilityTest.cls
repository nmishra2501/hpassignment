@isTest
private with sharing class CovidUtilityTest {

    @TestSetup
    static void setUpData(){
        Vaccination_Center__c vaccinationCenter = new Vaccination_Center__c();
        vaccinationCenter.Name = 'Dublin Clinic Center';
        vaccinationCenter.location__latitude__s = 12.12129182989821;
        vaccinationCenter.location__longitude__s = 13.12129182989821;
        insert vaccinationCenter;
    }
    
    //Unit test to test the business of finding Available Vacction Center to no of people
    @isTest 
    static void getVaccinationCenterInfoTest(){
        List<Vaccination_Center__c> vaccinationCenter = [Select Id, Location__c from Vaccination_Center__c];
        Map<String, List<People>> peopleDataAsperVacCenter = CovidUtility.getPeopleWithVaccinationCenter();
        System.assertNotEquals(null, peopleDataAsperVacCenter.values(), 'No people data found to vaccination center');
    }
}
