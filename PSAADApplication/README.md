# PSAADApplication

A Powershell module to create and manage Azure AD app registration or enterprise application without any dependency (like graph module). Create a multi-tier application (front end/Backend) with multiple APIs exposed can be painful and error prone when you do it from the portal. To my knowledge, you can’t even do it from tools like CLI/Powershell Az or other PS modules. This module requires you to provide templates using hashtable format. Look at the Templates folder to see all the available options to create your RBAC, desktop, SPA or web applications and simply follow on of the demo file at the root of this repo. The Demo03 allow you to create a backend AAD application (confidential), expose an API, create a public desktop application which will be allowed to pass tokens to this backend audience without opening the portal. Then for fun, you can change the logo of you apps :p.

## Install

# The module is not located on the PS gallery. You have to copy it manually.

```powershell
Import-Module .\PSAADApplication.psd1
```

## Disclaimer

This module was created AS IS with no warranty !
