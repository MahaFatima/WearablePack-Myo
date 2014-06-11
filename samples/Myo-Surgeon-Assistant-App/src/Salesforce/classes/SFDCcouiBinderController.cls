/*
 * @author Ammar Alammar  
 * @created_date 2014-01-30
 * @description Custom COntroller for the SFDCcouiBinder page. This is where you can add remote 
                methods to be eventually exposed to the Unity3D engine
 * @version 1.03
 * 
 */
 
 global with sharing class SFDCcouiBinderController{
  
    public SFDCcouiBinderController() { } // empty constructor
 
   
    @RemoteAction    // Declare the remote action
    global static Case orderPostOpXray(String procedureId) {
        
        // Retrieve case record as instructed by Unity3D & the sergeon 
		Case procedure = [SELECT Id, Request_Post_Op_Xray__c FROM Case WHERE Id = :procedureId];
        
        // fire-off salesforce configure workflows and tasks
        procedure.Request_Post_Op_Xray__c = true; 
        
        try {
            update procedure;
        } catch (DmlException e) {
            // Process exception here
        }
        
        return procedure;
    }
}
