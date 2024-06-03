SMConnector - Webex Registration Manual
---
Version: `2.1.1` - `2024-06-03` \
Author: martin@freedom-manufaktur.com \
Link: [Documentation on GitHub](https://github.com/freedom-manufaktur/SMConnector/tree/main/Documentation/Webex%20Registration%20Manual.md)

Table of contents
---
<!--TOC-->
- [1. Create a Service App](#1-create-a-service-app)
- [2. Authorize the App](#2-authorize-the-app)
- [3. Get Service App access tokens](#3-get-service-app-access-tokens)
- [4. Recap](#4-recap)
- [Need support?](#need-support)
<!--/TOC-->

# 1. Create a Service App
1.  As the primary manager of the Webex app, go to [Webex - My Apps](https://developer.webex.com/my-apps).
1.  Click [Create a New App](https://developer.webex.com/my-apps/new).
1.  Choose [Create a Service App](https://developer.webex.com/my-apps/new/service-app).
    1.  Fill name (this is being displayed to users, so we recommend choosing something meaningful).
    2.  Choose an icon (this is also displayed to users).
    3.  Specify *Description*, *Contact Email*.
    4.  Under *Scopes* select the following
        - `spark:memberships_read`
        - `spark:memberships_write`
        - `spark:messages_read`
        - `spark:messages_write`
        - `spark:people_read`
        - `spark:rooms_read`
        - `spark:rooms_write`
    5. Finally, click *Add Service App*.
2. After the app has been created, choose **Request admin authorization**.
   > After clicking this, do **not** modify the *Scopes* unless your admin has revoced the current authorization.
3. Write down the **Client ID** (e.g. `Cf395ddc49c29e0f2c81923eae527ab28b3538e2b91d42bd80f3e32936fd2f52c`)
4. Write down the **Client Secret** (e.g. `17d2a5e54ee468b76befa3634a630d1a706a49a45ebbe8c25b43e3161533b045`)

# 2. Authorize the App
1. Go to [Webex Control Hub - Apps](https://admin.webex.com/apps/service-apps).
2. Select the app you have submitted in step [1. Create a Service App](#1-create-a-service-app).
3. Toggle the **Authorization** → **Authorize** to **Authorized**.
3. Click **Save**.

1. Go to [Webex Control Hub - Account - Info](https://admin.webex.com/account/info)
2. Write down the **Organization ID** (e.g. `356187e1-2c49-45ce-8d4d-30ebf4906c88`)

# 3. Get Service App access tokens
1. Go back to [Webex - My Apps](https://developer.webex.com/my-apps) and select the app created in step [1. Create a Service App](#1-create-a-service-app)
2. Under **Org Authorizations** select your organization.
   > You may refresh the page if you don't see this section.
4. Enter the **Client Secret** you have witten down.
5. Click **Generate tokens**.
6. Write down the **refresh_token**.
   > You can ignore the **access_token**, as we generate those from the **refresh_token**.

# 4. Recap
You should now have the following values
- Organization ID (e.g. `356187e1-2c49-45ce-8d4d-30ebf4906c38`)
- Client ID (e.g. `Cf395ddc49c29e0f2c81923eae527ab28b3538e2b91d42bd80f3e32936fd2f52c`)
- Client Secret (e.g. `17d2a5e54ee468b76befa3634a630d1a706a49a45ebbe8c25b43e3161533b045`)
- refresh_token (e.g. `ZmYwMmM2ODktMjgzZS00NjE2LWFhMmEtZTI0ZmI2M2Q5Njg3YzMwOWQ5NDItNDMz_P0A1_356187e1-2c49-45ce-8d4d-30ebf4906c38`)

This is everything you need to configure your *SMConnector* for *Webex*.

# Need support?
If you have any questions regarding the installation or configuration of the *SMConnector*, contact us at
* All questions regarding *Ticket2Teams* or *Ticket2Webex* \
  support@gentlemengroup.de (Gentlemen Group)
* All questions around the *SMConnector* microservice \
  support@freedom-manufaktur.com (freedom manufaktur)
