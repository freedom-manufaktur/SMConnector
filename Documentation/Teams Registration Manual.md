SMConnector - Microsoft Teams Registration Manual
---
Version: `2.1.3` - `2024-09-09` \
Author: martin@freedom-manufaktur.com \
Link: [Documentation on GitHub](https://github.com/freedom-manufaktur/SMConnector/tree/main/Documentation/Teams%20Registration%20Manual.md)

Table of contents
---
<!--TOC-->
- [1. Entra ID (Azure AD) Application registration](#1-entra-id-azure-ad-application-registration)
- [2. Prepare a service account](#2-prepare-a-service-account)
  - [Test the account](#test-the-account)
  - [Customize the account](#customize-the-account)
- [3. Recap](#3-recap)
- [Need support?](#need-support)
<!--/TOC-->

# 1. Entra ID (Azure AD) Application registration
To access your Entra ID without giving full access to everything inside your organization, Microsoft 
provides a way to define an "Entra ID App". This App has a unique ID and Service Account, making 
sure you only expose the information as much as needed for the Integration to work.

1.  Open the [Entra ID - App registrations](https://entra.microsoft.com/#view/Microsoft_AAD_RegisteredApps/ApplicationsListBlade/quickStartType~/null/sourceType/Microsoft_AAD_IAM) portal.

2.  Add a new registration and give it a fitting name.\
    ![New App registration](Images/Entra%20ID%20App%20registration%20New.png)

3.  Write down the *Application ID* (e.g. `ad1baadb-614b-4e7d-890c-74a3ac85862c`) and  *Tenant ID* (e.g. `9776b2ed-e415-439d-9582-85719af85979`).\
    ![App registration ID](Images/Entra%20ID%20App%20registration%20ID.png)

4.  Navigate to **Authentication** and enable **Allow public client flows**\
    ![App registration public client flows](Images/Entra%20ID%20App%20registration%20Public%20client%20flows.png)

5.  Under **API permissions** make sure that you have at least the following permissions:
    - `Chat.Create` (Delegated)\
      Allows the App to create new chats.
    - `Chat.ReadWrite` (Delegated)\
    Allows the App to get information about a chat and change a chats topic
    - `ChatMember.ReadWrite` (Delegated)\
    Add and remove members to/from the chat.
    - `ChatMessage.Read` (Delegated)\
    Read the chat messages inside a chat.
    - `ChatMessage.Send` (Delegated)\
    Send chat message to a chat.
    - `Files.Read.All` (Delegated)\
    Allow access to files shared inside a chat. This is typically through the sharing users OneDrive.
    - `User.Read` (Delegated)\
    Get information about the Service Account user using the App.
    - `User.ReadBasic.All` (Delegated)\
    Get information about chat members (other users) that should be added to /removed from a chat.

    Once you have added the permissions, use **Grant admin consent for MyCompany** and make sure all permissions have admin consent.\
    ![App registration permissions](Images/Entra%20ID%20App%20registration%20Permissions.png)

# 2. Prepare a service account
The SMConnector works with delegated permissions. This means that we need an ordinary user that has the following preconditions:
- You must know the username and password.
- The user must has an active *Teams* license.
- The user must be excluded from 2-factor-authentication.
  > There is a possible workaround to allow authentication for accounts that can't use username and password or must have 2FA. Please contact the support for assistance.

## Test the account
- Open [Teams](https://teams.microsoft.com) in a private browser window
- Sign in to Microsoft and make sure that you must **only** specify username and password, nothing else.
- Ensure that *Teams* can be used like any other user.

## Customize the account
Other users will see the account name, picture and contact details inside the chats.
It's a good idea to spend some time personalizing the account for the best user experience.

# 3. Recap
You should now have the following values
- Entra ID Application ID (e.g. `ad1baadb-614b-4e7d-890c-74a3ac85862c`)
- Entra ID Tenant ID (e.g. `9776b2ed-e415-439d-9582-85719af85979`)
- Service account username
- Service account password

This is everything you need to configure your *SMConnector* for *Microsoft Teams*.

# Need support?
If you have any questions regarding the installation or configuration of the *SMConnector*, contact us at
- All questions regarding *Ticket2Teams* or *Ticket2Webex* \
  support@gentlemengroup.de (Gentlemen Group)
- All questions around the *SMConnector* microservice \
  support@freedom-manufaktur.com (freedom manufaktur)
