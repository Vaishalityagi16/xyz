import { LightningElement, api } from 'lwc';
import Summary from '@salesforce/schema/Account.Account_Activation_Summary__c';
import Active from '@salesforce/schema/Account.Active__c';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions';

export default class RecordEditFormExample extends LightningElement {
    // Expose a field to make it available in the template
    nameField = Summary;
    activeField = Active;
    str = '';
    // Flexipage provides recordId and objectApiName
    @api recordId;
    @api objectApiName;

    handleSubmit(event){
        // event.preventDefault();       // stop the form from submitting
        // if(this.str){
        //     this.showToast('Error', 'Account Summary is required!', 'error');
        // }
        // else{
        //     this.template.querySelector('lightning-record-edit-form').submit(event.detail.fields);
        // }
    }
    handleError(event){
        this.showToast(event?.detail?.detail,event?.detail?.message, 'error');
    }
    handleSuccess(event){
        this.showToast('Successfully!','Update', 'Success');
        this.dispatchEvent(new CloseActionScreenEvent());
    }
    handleChange(event){
        this.str = event.target.value;
    }

    showToast(tle,msg,type) {
        const event = new ShowToastEvent({
            title: tle,
            message: msg,
            variant: type,
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
}