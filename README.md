# Another way to create app registration/Enterprise app

## Introduction

Creating an application in AAD as always been a “funny” topic. Why Terraform/Pulumi can do this easily while ARM template struggle (and no I don’t consider [deployment scripts](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deployment-script-template) as a solution) … Anyway, the goal of this repo is to propose another solution based on Powershell and Graph API exclusively because according to me **az ad sp create** or **New-AzADApplication** have some limitations. It still a work in progress, and I don’t know if more efforts should be spent into this idea, but for now it’s a good support to explain the AAD application world (main idea of this repo). Another possibility can be to use this into a pipeline to manage your applications lifecycle with IAC (maybe TF/Pulumi are better options in this case).

## How to use this repo

**You can find the "compiled" module (psd1 and psm1) in the PSAADApplication folder.**

There is 2 main things to keep in mind:

- The Demo01, 02, 03 will help you to use this module
- Between various applications types (RBAC/Desktop/SPA/...), and the douzens of options, you can read also the files in the Templates folder to understand all the available options to configure your applications.
- The APIScopesInfo cmdlet is useful when you have to list exposed apis from Graph or your app registration. I use it during the demo03 to get the auto generated ID that has been generated when I exposed an API from my backend application.
