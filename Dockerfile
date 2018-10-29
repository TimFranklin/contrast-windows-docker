FROM microsoft/aspnet:4.7
ARG site_root=.

RUN md C:\contrast
WORKDIR /contrast

# Install nuget
ADD https://dist.nuget.org/win-x86-commandline/latest/nuget.exe /Windows

RUN \Windows\nuget.exe install Contrast.NET.Azure.AppService

COPY ./Startup.ps1 C:/contrast

# Install the site
ADD ${site_root} /inetpub/wwwroot

# Setup Contrast .NET Agent and start the site
ENTRYPOINT [ "powershell.exe", "C:\\contrast\\Startup.ps1" ]