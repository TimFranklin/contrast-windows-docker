mkdir "C:\contrast\lib"
mkdir "C:\contrast\data"
mkdir "C:\contrast\data\logs"

$nugetPath = (Get-ChildItem "C:\contrast\Contrast.NET.Azure.AppService.*\content\contrastsecurity")[0].FullName
(Get-ChildItem $nugetPath) | ForEach-Object {
    Copy-Item -Path $_.FullName -Destination "C:\contrast\lib" -Recurse -Force
}

#Required settings
$env:COR_ENABLE_PROFILING = "1"
$env:COR_PROFILER = "{EFEB8EE0-6D39-4347-A5FE-4D0C88BC5BC1}"
$env:COR_PROFILER_PATH_32 = "C:\contrast\lib\ContrastProfiler-32.dll"
$env:COR_PROFILER_PATH_64 = "C:\contrast\lib\ContrastProfiler-64.dll"
$env:CONTRAST_INSTALL_DIRECTORY = "C:\contrast\lib\"
$env:CONTRAST_DATA_DIRECTORY = "C:\contrast\data\"
$env:CONTRAST_LOGS_DIRECTORY = "C:\contrast\data\logs\"
$env:AGENT__DOTNET__CONTAINER = "true"

# Change TeamServerUrl if using another TeamServer instead of https://app.contrastsecurity.com
# $env:CONTRAST__URL = "https://my_url.com"

# Account authentication settings from TeamServer My Account page, or agent's DotnetSettings.ini file
# $env:CONTRAST__URL = "MY_USERNAME"
# $env:CONTRAST__SERVICE_KEY = "MY_SERVICE_KEY"
# $env:CONTRAST__API_KEY = "MY_API_KEY"

# More Customizations. See https://docs.contrastsecurity.com/installation-netconfig.html#net-yaml for all settings
# $env:AGENT__LOGGER__LEVEL = "trace"
# $env:SERVER__NAME = "MyServerContainer"
# $env:SERVER__TAGS = "ServerTags"
# $env:APPLICATION__NAME = "My Application"
# $env:APPLICATION__TAGS = "AppTags"
# $env:INVENTORY__TAGS = "LibraryTags"
# $env:ASSESS__TAGS = "FindingTags"


# Run ServiceMonitor as the entrypoint like the official aspnet images
C:\ServiceMonitor.exe w3svc