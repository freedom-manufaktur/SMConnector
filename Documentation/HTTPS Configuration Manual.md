SMConnector - HTTPS Configuration Manual (Windows)
---
Version: `2.6.0` - `2026-02-17` \
Author: [martin@freedom-manufaktur.com](mailto:martin@freedom-manufaktur.com) \
Link: [Documentation on GitHub](<https://github.com/freedom-manufaktur/SMConnector/tree/main/Documentation/HTTPS Configuration Manual.md>)

Table of contents
---
<!--TOC-->
- [1. Acquire a certificate](#1-acquire-a-certificate)
- [2. Set permissions](#2-set-permissions)
- [3. Configure application settings](#3-configure-application-settings)
- [4. Restart SMConnector](#4-restart-smconnector)
- [Need support?](#need-support)
<!--/TOC-->

# 1. Acquire a certificate
You need to acquire a valid TLS certificate for public internet access.

> SMConnector provides public (internet accessible) endpoints, which allow users to view images and other attachments inside a chat. Intranet or self-signed certificates only provide a limited functionality.

The acquired certificate should be available in the *Manage computer certificates* management console.

![Windows Certificates](<Images/Windows Certificates.png>)

# 2. Set permissions
> SMConnector uses a [minimum privileges](https://learn.microsoft.com/en-us/windows/win32/services/localservice-account) account, which - by default - does not have access to private keys.

1. Right click the certificate, select **All Tasks** → **Manage Private Keys...**.
2. Add the user **LOCAL SERVICE** and allow **Read** access.

![Local Service certificate access](<Images/Windows Certificates Local Service.png>)

# 3. Configure application settings
Navigate to the directory \
`%ProgramData%\freedom manufaktur\SMConnector` \
This directory contains the configuration for the app `appsettings.json` as well as some other app files.
Editing `appsettings.json` will show something like:
```
{
  "Urls": "http://localhost:8000",
  "[Example]Kestrel": {
    "Certificates": {
      "Default": {
        "$Help.Subject": "Subject without 'CN='. E.g. localhost",
        "Subject": "localhost",
        "$Help.Store": "My | Root |..., See https://learn.microsoft.com/en-us/dotnet/api/system.security.cryptography.x509certificates.storename?view=net-10.0",
        "Store": "My",
        "$Help.Location": "CurrentUser | LocalMachine",
        "Location": "LocalMachine",
        "$Help.AllowInvalid": "Allow invalid certificates? E.g. self-signed",
        "AllowInvalid": true
      }
    }
  }
}
```
You should edit the sections `Urls` and `Kestrel:Certificates`.

> Your `Kestrel` section may be named `[Example]Kestrel`, which is an example that has no effect. Remove the `[Example]` tag to enable the section.

In our example, we would end up with the following settings:
```
{
  "Urls": "https://SMConnector.MyCompany.com:8000;https://localhost:8000",
  "Kestrel": {
    "Certificates": {
      "Default": {
        "Subject": "MyCompany.com",
        "Store": "My",
        "Location": "LocalMachine",
        "AllowInvalid": false
      }
    }
  }
}
```

> There are other ways to configure HTTPS, e.g. through `.pfx`, `.pem` or `.crt` files. Learn more about those methods [here](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/servers/kestrel/endpoints?view=aspnetcore-10.0#configure-https-in-appsettingsjson).

# 4. Restart SMConnector
After any modifications to `appsettings.json`, you need to restart the SMConnector service for the changes to take effect.

Test the changes by visiting https://SMConnector.MyCompany.com:8000
You should be greeted with a welcome message.

# Need support?
If you have any questions regarding the installation or configuration of the *SMConnector*, contact us at
- All questions regarding *Ticket2Teams* or *Ticket2Webex* \
  [services@gentlehuman.de](mailto:services@gentlehuman.de) (Gentlehuman Factory)
- All questions around the *SMConnector* microservice \
  [support@freedom-manufaktur.com](mailto:support@freedom-manufaktur.com) (freedom manufaktur)