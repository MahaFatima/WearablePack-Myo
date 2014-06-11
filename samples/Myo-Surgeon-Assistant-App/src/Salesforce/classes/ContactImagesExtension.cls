/*
 * @author Ammar Alammar  
 * @created_date 2014-01-30
 * @description A controller extension to retrieve the patient image link 
 *              to be used in a merge field within the patientInfo page
 * @version 1.03
 * 
 */
 
 public with sharing class ContactImagesExtension{
 
    private ApexPages.standardController controller;
    private Contact patient;
    private Attachment photo;
  
    public ContactImagesExtension(ApexPages.StandardController controller) {
        this.controller = controller;
        this.patient = (Contact)controller.getRecord();
    }
 
    public Id patientPhotoId {
        get {
            if(photo == null){
                try{
                	this.photo = [SELECT Id, Name 
                    	          FROM Attachment 
                        	      WHERE ParentId = :patient.Id AND Name = 'ProfilePic'
                            	  LIMIT 1][0];   
                }
                catch (Exception e){
                    // In a production system, a thorough exception handling shoud be applied here.
                    System.Debug(e.getMessage());
                }
                 
            }
            return this.photo.Id;
        }
    }
}
