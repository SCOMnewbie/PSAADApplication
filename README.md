# Another way to create app registration/Enterprise app

## Introduction

Creating an application in AAD as always been a “funny” topic. Why Terraform/Pulumi can do this easily while ARM template struggle (and no I don’t consider [deployment scripts](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deployment-script-template) as a solution) … Anyway, the goal of this repo is to propose another solution based on Powershell and Graph API exclusively because according to me **az ad sp create** or **New-AzADApplication** have some limitations. It still a work in progress, and I don’t know if more efforts should be spent into this idea, but for now it’s a good support to explain the AAD application world (main idea of this repo). Another possibility can be to use this into a pipeline to manage your applications lifecycle with IAC (maybe TF/Pulumi are better options in this case).

## How to use this repo

There is 2 main things to keep in mind:

- The demo.ps1 is what we will use for our demo. The demo will be cleaned at the end of the script.
- Between applications (RBAC/Desktop/SPA/...), we still have to copy/paste $settings from Templates/xxx to Convert-SettingsToJson.ps1 between the apps. It's not optimal, but I didn't found a smart way way to generate the "compiled" json on the fly.

Note: I've tried to expose lot of possibilities in the templates. The idea here is for you to create your own template based on pieces located in various examples.

Note2: Get-GraphAPIScopesInfo can be used to extract from graph api itself the ID of the specifc scopes you need in your future application.
