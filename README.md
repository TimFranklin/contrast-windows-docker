# Dockerfile - Contrast .NET Agent running in Windows Docker container

This image can be used just like the [`microsoft/aspnet`](https://hub.docker.com/r/microsoft/aspnet/).  At container startup, it will perform these additional steps:

1. Download the latest nuget.exe
2. Create a contrast folder under c:\contrast
2. Use Nuget to download the latest release of the [Contrast Azure Extension].  (https://www.nuget.org/packages/Contrast.NET.Azure.AppService/).  Extract agent files in the contrast folder
4. Create folders under c:\contrast for agent data and log files
5. Run your site with the Contrast.NET agent and any agent customizations

## Creating a base image

Identify the version of the [microsoft/aspnet](https://hub.docker.com/r/microsoft/aspnet/) image to base your image on and update the Dockerfile e.g.
```Dockerfile
FROM microsoft/aspnet:4.7.2-windowsservercore-1803
...
```

> Only .NET 4 and up images are supported in Docker.  The aspnet:3.5 image will not work.

Then run the docker build script, specifying the path to your application

```posh
PS> docker.exe build -t contrast-aspnet --build-arg site_root=c:\sites\mydeployedapp .
```

## Running your container

When running the image, you can customize it with any of the YAML settings by passing in the corresponding environment variable.  At minimum you will need to pass in these three settings for authentication :
* CONTRAST__USER_NAME 
* CONTRAST__SERVICE_KEY
* CONTRAST__API_KEY

For example:

```posh
PS> docker.exe run -d --name contrast1 -e "CONTRAST__USER_NAME=MyUserName" -e "CONTRAST__SERVICE_KEY=MyServiceKey" -e "CONTRAST__API_KEY=MyApiKey" contrast-aspnet:latest

```

> Alternately you can embed your settings in the image by changing the `Startup.ps1` before building your image.

For all available options to customizing the agent with environment variables please see [Contrast Documentation](https://docs.contrastsecurity.com/installation-netconfig.html#net-yaml)