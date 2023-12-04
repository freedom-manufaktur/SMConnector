SMConnector2Teams - Microservice Installation Manual
---
Version: `1.13.2` - `2023-12-04` \
Author: martin@freedom-manufaktur.com \
Link: [Documentation on GitHub](https://github.com/freedom-manufaktur/SMConnector2Teams/tree/main/Documentation/Microservice%20Installation%20Manual.md)

Table of contents
---
<!--TOC-->
- [1. Microservice Installation](#1-microservice-installation)
  - [Installation as Windows Service](#installation-as-windows-service)
  - [Installation as Docker Container via Docker Compose](#installation-as-docker-container-via-docker-compose)
  - [Installation as Kubernetes Deployment via HELM Chart](#installation-as-kubernetes-deployment-via-helm-chart)
- [2. Install Ticket2Teams](#2-install-ticket2teams)
- [Need support?](#need-support)
<!--/TOC-->

# 1. Microservice Installation
There are different kinds of installation. You may choose the one best suiting your needs.
* Windows Service \
   ✔ lightweight \
   ✔ easy to install, update and configure \
   ⚠ Windows only \
   ℹ .NET required (installed automatically)
* Docker Container via Docker Compose \
   ✔ containerized \
   ✔ cross platform \
   ⚠ Docker with [Docker Compose v2](https://docs.docker.com/compose/) required
* Kubernetes Deployment via [HELM Chart](https://helm.sh/) \
   ✔ containerized \
   ✔ scalable \
   ✔ cross platform \
   ⚠ Kubernetes installation required \
   ⚠ [HELM](https://helm.sh/docs/intro/install/) installation required \
   ⚠ Experience with Kubernetes and HELM Charts required

## Installation as Windows Service

**Installation**

1.  Download Installation from [SMConnector2Teams Download](https://freedommanufaktur.sharepoint.com/:f:/g/Ei5ui1vR2N5FkDdc6O7vxIwBQ3lJ7BJrXECeTJ32JEhRsA?e=8vqyJR)
1.  *(Optional, when offline*) Download and install the most recent [.NET 8.0 Runtimes](https://dotnet.microsoft.com/en-us/download/dotnet/8.0)
    1. ASP.NET Core Runtime x64 Installer
    2. .NET Runtime x64 Installer
1.	Install `SMConnector2Teams Setup 1.13.2`
    > Note: This will automatically install .NET 8.0 if necessary
1.  (Optional, verify running) Open a browser and navigate to \
    http://localhost:8000 \
    You should be greeted with the message\
    `Welcome to the SMConnector2Teams Microservice`
1.	Allow inbound traffic to the service.
    > The default port used is `8000`. You may change the port number at any time.
    * Use a Reverse Proxy, like IIS [Application Request Routing](https://www.iis.net/downloads/microsoft/application-request-routing) to redirect traffic to port `8000`.
        > This is the **recommended** option, as you can perform TLS/SSL termination before hitting the service and running the service in combination with other apps.

    *OR*

    * Configure your Windows Firewall to allow inbound traffic to port `8000`
        > Note: You must bind a certificate to this port and use TLS/SSL (see *Configuration*).

1.  As a result of the previous steps you should have a publically accessible and TLS secured endpoint like **https://SMConnector.MyCompany.com**. \
    We will use this address in the next steps.

**Upgrade an existing Installation**

1.	(Optional, when Offline) Download and install the most recent [.NET 8.0 Runtimes](https://dotnet.microsoft.com/en-us/download/dotnet/8.0)
    1.  ASP.NET Core Runtime x64 Installer
    1.	.NET Runtime x64 Installer
1.	Install `SMConnector2Teams Setup vNext.exe` \
    This will upgrade your existing installation.

**Configuration**

If port `8000` (default) is already in use or you want to set any other option, then navigate to the directory \
`%ProgramData%\freedom manufaktur\SMConnector2Teams` \
This directory contains the configuration for the app `appsettings.json` as well as some other app files.
Editing `appsettings.json` will show something like
```
{
  "$Help.Urls": "Enter the URLs you want the App to be available at. For example https://localhost:8001;http://localhost:8000",
  "Urls": "https://localhost:8443",
  "$Help.UseHttpsRedirection": "Should all requests to HTTP URLs be redirected to HTTPS (recommended, requires HTTPS URL).",
  "UseHttpsRedirection": false,
  "Api": {
    "$Help.EnableDetailedErrorMessages": "Enable to include the full stack trace when an error occurs while calling the API.",
    "EnableDetailedErrorMessages": false
  }
}
```
As seen in the example, the URL has been re-configured to use https://localhost:8443 as address and detailed error messages have been enabled. \
*After changing `appsettings.json` you must restart the `SMConnector2Teams` Service.*

**Monitoring / Debugging**

The installation creates a new Windows Service that should be running for the service to be available

![Alt text](Images/Windows%20Service.png)

The installation also creates a new Windows Event Log source `SMConnector2Teams`. Please start the *Event Viewer* or any other Event Log monitoring tool to view the application logs.

![Alt text](Images/Windows%20Service%20Event%20Log.png)

---

## Installation as Docker Container via Docker Compose

> Attention: Starting with version 1.12.0 of `SMConnector2Teams` the docker images are **non-root** based.
> You **should** use `SMConnector2Teams` version 1.13.2 or later combined with `compose.yaml` version 1.13.2 or later.

**Installation and Configuration**

1. Download the **sm-connector-to-teams** Docker image from [SMConnector2Teams Download](https://freedommanufaktur.sharepoint.com/:f:/g/Ei5ui1vR2N5FkDdc6O7vxIwBQ3lJ7BJrXECeTJ32JEhRsA?e=8vqyJR) and register it with your image repository.

1. Download the Docker Compose YAML files from [SMConnector2Teams Docker Compose Download](https://github.com/freedom-manufaktur/SMConnector2Teams/tree/main/Docker%20Compose).

1. Adjust the `compose.env` with the required settings.
   > Note: Read the following chapters if you do not have all the required information.

1. Use the command `docker compose --env-file .\compose.env up` to deploy the app.

1. (First time setup) When you install the application for the first time, it will **not** be considered healthy.\
   You must first configure the app via its configuration API. This is typically done via the **Ticket2Teams configuration** UI.\
   To access the API you do need an **API key**, which you can aquire from the logs.\
   Use any tool of your liking to view the application logs.\
   The application log should contain a text that reads
   ```
   ATTENTION REQUIRED: This service uses an API key to protect from unauthorized access. The API key has not been used yet, so we have generated one for you.
      Please use 'Basic authorization' with username 'USM' and '********************************************' as password.
       
      Alternatively you can set the authorization header: Authorization: Basic ****************************************************************
   ```
   Please write down the password and follow the **Ticket2Teams** installation manual on where to enter the password.

**Monitoring / Debugging**

> The Docker Compose file contains a [healthcheck](https://docs.docker.com/compose/compose-file/05-services/#healthcheck) definition that includes basic configuration checks.

Use your favorite Docker tools to check the status and logs of the app.
For example in Docker Desktop \
![Docker Compose Container Running](Images/Docker%20Compose%20Running.png)

---

## Installation as Kubernetes Deployment via HELM Chart

> Attention: Starting with version 1.12.0 of `SMConnector2Teams` the docker images are **non-root** based.
> You **should** use `SMConnector2Teams` version 1.13.2 or later combined with `Chart.yaml` version 1.13.2 or later.

**Installation and Configuration**

1. Download the **sm-connector-to-teams** Docker image from [SMConnector2Teams Download](https://freedommanufaktur.sharepoint.com/:f:/g/Ei5ui1vR2N5FkDdc6O7vxIwBQ3lJ7BJrXECeTJ32JEhRsA?e=8vqyJR) and register it with your image repository.

1. Download the HELM Chart files from [SMConnector2Teams HELM Chart Download](https://github.com/freedom-manufaktur/SMConnector2Teams/tree/main/HELM%20Chart).

1. Adjust the `values.yaml` with the required settings.
   > Note: Read the following chapters if you do not have all the required information.

1. Use the command `helm upgrade sm-connector . --install` to deploy the app.

1. (First time setup) When you install the application for the first time, it will **not** be considered healthy.\
   You must first configure the app via its configuration API. This is typically done via the **Ticket2Teams configuration** UI.\
   To access the API you do need an **API key**, which you can aquire from the logs.\
   Use the following commands or any tool of your liking to view the application logs.
   ```
   ### Get logs (Bash) ###
   export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=sm-connector-to-teams,app.kubernetes.io/instance=sm-connector" -o jsonpath="{.items[0].metadata.name}")
   kubectl logs $POD_NAME
   ### End of Bash ###
   
   ### Get logs (PowerShell) ###
   $POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=sm-connector-to-teams,app.kubernetes.io/instance=sm-connector" -o jsonpath="{.items[0].metadata.name}")
   kubectl logs $POD_NAME
   ### End of PowerShell ###
   ```
   The application log should contain a text that reads
   ```
   ATTENTION REQUIRED: This service uses an API key to protect from unauthorized access. The API key has not been used yet, so we have generated one for you.
      Please use 'Basic authorization' with username 'USM' and '********************************************' as password.
       
      Alternatively you can set the authorization header: Authorization: Basic ****************************************************************
   ```
   Please write down the password and follow the **Ticket2Teams** installation manual on where to enter the password.

1. Use the command `helm test sm-connector` to test the deployed app. \
   Expecting to see `Phase: Succeeded`.

**Monitoring / Debugging**

> The Kubernetes Deployment contains [readiness and liveness probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) that include basic configuration checks.

Use your favorite Docker tools to check the status and logs of the app.
For example in Kubernetes Dashboard \
![Docker Kubernetes Running](Images/Kubernetes%20Running.png)

# 2. Install Ticket2Teams
1.  Follow the **Ticket2Teams** installation manual to install **Ticket2Teams** into your *USU Service Manager (USM)*.

1.  Finish entering all the required settings into your **Ticket2Teams configuration** UI.
    > Use the **URL** and **API key** password that we generated earlier here.
    
    ![Ticket2Teams Configuration](Images/Ticket2Teams%20Configuration.png)

3.  (Optional) Open a browser and enter the URL of **your** microservice and append `/healthcheck` \
    For example **`https://SMConnector.MyCompany.com/healthcheck`** \
    This should result in a page where everything has the status **Healthy**.
    ```
    {
      "status": "Healthy",
      "components": [
        {
          "name": "Graph",
          "status": "Healthy"
        },
        {
          "name": "License",
          "status": "Healthy"
        }
      ]
    }
    ```
    If that is not the case, please go back to the previous steps and try again.

4.  Done!
    > Congratulations on successfully installing and configuring the **SMConnector2Teams**.

# Need support?
If you have any questions regarding the installation and configuration of the SMConnector2Teams, contact us at
* All questions regarding the *Ticket2Teams* \
    support@gentlemengroup.de (Gentlemen Group)
* All questions around the *SMConnector2Teams* microservice \
    support@freedom-manufaktur.com (freedom manufaktur)
* All questions regarding the *USU Service Manager* itself \
    support@usu.com (USU)
