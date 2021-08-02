public class People {
    @AuraEnabled
    public String latitude{get;set;}
    @AuraEnabled
    public Integer age{get;set;}
    @AuraEnabled
    public String longitude{get;set;}
    @AuraEnabled
    public String name{get;set;}
    @AuraEnabled
    public String nearestCenter{get;set;}

    // method to parse the JSON data and return the list of people data
    public static List<People> parse(String json){
        return (List<People>) System.JSON.deserialize(json, List<People>.class);
    }
}
