## Installation

### Prerequisites

- [ ] Sign-up for a Salesforce Developer Edition account
  - https://developer.salesforce.com/signup
- [ ] Install the Salesforce CLI (SFDX) tool
  - https://developer.salesforce.com/tools/salesforcecli

### SFDX: Authorize Org

`sf org login web --alias paas-cloud-goat --set-default`

Follow the web browser prompts to authorized the CLI
- Reference: https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_auth_web_flow.htm

### Org Settings
- Defaults from a Developer Edition account are sufficient
- FYI on Profiles:
  - System Administrator will be used to view all “sensitive app” data
  - Standard User will be the less-privileged user
  - Only “Profiles” are used for authZ; not Roles

### Deploy the App
1. Go into the base directory for paas-cloud-goat
1. `sfdx force:source:deploy -p force-app\main`

## Test Data Setup

### Building custom objects
1. Login as the System Administrator
1. Search for the “Paas Cloud Goat” app
1. Buildings tab
1. New
1. Create a few buildings with a few PINs (any values you want)
   - HQ	EntryPIN=123123
   - Satellite
   - Bunker
   - Research
   - Vault

See also [Sample Test Data - Building__c.csv](/Resources/Sample%20Test%20Data%20-%20Building__c.csv) if you know how to bulk import and want to save some clicks

### Private contact
1. Still logged-in as the "System Administrator" profile
1. Contaccts tab
1. New
   1. Fill-in the required name
   1. Do NOT associate with any "Account" field
  
### SecretSauce custom object
1. Still logged-in as the "System Administrator" profile
1. SecretSauce tab
1. New
   - Fill-in the fields with any data you want
1. Repeat creating a few SecretSauce objects

## Low privilege user creation
1. Create a new Salesforce user
   - Most fields you can use any value
   - Make sure e-mail is valid
     - (Plus-aliasing may help:  myname+standard.sf@example.org)
1. User License = Salesforce
1. Profile = Standard User
1. Role = _leave blank_
1. Await the e-mail and setup your account credentials
   - "Welcome to Salesforce: Verify your account"
