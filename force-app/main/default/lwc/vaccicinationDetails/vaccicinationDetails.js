import { LightningElement, wire, track } from 'lwc';
import getVaccinationCenterInfo from '@salesforce/apex/CovidUtility.getPeopleWithVaccinationCenter';

export default class VaccicinationDetails extends LightningElement {
    vaccicinationInfo = [];
   
    @track mapData= [];

    @wire(getVaccinationCenterInfo)
    wiredResult(result){
        this.vaccicinationInfo = result.data;

        for(var key in this.vaccicinationInfo){            
            let array = this.vaccicinationInfo[key].slice().sort((a, b) => b.age - a.age)
            this.mapData.push({value:array, key:key}); //Here we are creating the array to show on UI.
        }
    }
    async invokeApexMethods(){       
        this.vaccicinationInfo = await getVaccinationCenterInfo();
   }
}