# Script used for invitng users to a ML workspace in Azure that a usergroup has been assinged RBAC rights on

## Edit this to the intended securitygroup $SecurityGroup = "objectID of the Security Group"

# Once run it will Promt for Email
# Then it Adds email as user to AD and specificed user group 
# run from Cloudshell in VSCode or in Azure Cloudshell



Connect-AzureAD

$UserInvited = Read-Host -Prompt 'Enter email'

#$UserInvited = ""

$SecurityGroup = "objectID of the Security Group"

New-AzureADMSInvitation -InvitedUserEmailAddress $UserInvited -InvitedUserDisplayName $UserInvited -SendInvitationMessage $True -InviteRedirectUrl "http://ml.azure.com/"

$MemberID = (Get-AzureADUser -Filter "DisplayName eq '$UserInvited'").objectid

Add-AzureADGroupMember -ObjectId "$SecurityGroup" -RefObjectId $MemberID
