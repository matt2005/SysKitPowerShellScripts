Function Computer_ApplicationPoolAutostartSettings
{
param(
$Computername,
$Credential
)
$output=Invoke-Command -Computername $Computername -Credential $Credential -ScriptBlock { Import-Module WebAdministration
################
# SYSKIT
# www.syskit.com
<#
Displays ApplicationPool autostart settings for all ApplicationPools on the selected Computer. Run on any Computer.
#>
################
Get-WebConfigurationProperty /system.applicationhost/applicationpools -name * | select -expand collection | select name, startmode, enable32BitAppOnWin64, managedRuntimeVersion, managedRuntimeLoader, enableConfigurationOverride, CLRConfigFile, passAnonymousToken, state, Attributes, ChildElements, ElementTagName, Methods

}
return $output
}
Function Computer_ApplicationPoolFailureSettings
{
param(
$Computername,
$Credential
)
$output=Invoke-Command -Computername $Computername -Credential $Credential -ScriptBlock { Import-Module WebAdministration
################
# SYSKIT
# www.syskit.com
<#
Displays ApplicationPool rapid failure settings for all ApplicationPools on the selected Computer. Run on any Computer.
#>
################
Get-WebConfigurationProperty /system.applicationhost/applicationpools -name * | select -expand collection | select name -expand Failure |select name, RapidFailProtection, RapidFailProtectionInterval, RapidFailProtectionMaxCrashes, autoShutdownExe, autoShutdowParams

}
return $output
}
Function Computer_ApplicationPoolIdentitySettings
{
param(
$Computername,
$Credential
)
$output=Invoke-Command -Computername $Computername -Credential $Credential -ScriptBlock { Import-Module WebAdministration
################
# SYSKIT
# www.syskit.com
<#
Displays ApplicationPool identity settings for all ApplicationPools on the selected Computer. Run on any Computer.
#>
################
Get-WebConfigurationProperty /system.applicationhost/applicationpools -name * | select -expand collection | select name -expand processmodel | select name, identitytype, loaduserprofile, username

}
return $output
}
Function Computer_ApplicationPoolOrphanAction
{
param(
$Computername,
$Credential
)
$output=Invoke-Command -Computername $Computername -Credential $Credential -ScriptBlock { Import-Module WebAdministration
################
# SYSKIT
# www.syskit.com
<#
Displays ApplicationPool Orphan action settings for all ApplicationPools on the selected Computer. Run on any Computer.
#>
################
Get-WebConfigurationProperty /system.applicationhost/applicationpools -name * | select -expand collection | select name -expand Failure |select name, OrphanActionExe, OrphanActionParams, OrphanWorkerProcess

}
return $output
}
Function Computer_ApplicationPoolProcessModel
{
param(
$Computername,
$Credential
)
$output=Invoke-Command -Computername $Computername -Credential $Credential -ScriptBlock { Import-Module WebAdministration
################
# SYSKIT
# www.syskit.com
<#
Displays ApplicationPool ping settings and startup and shutdown time limits for all ApplicationPools on the selected Computer. Run on any Computer.
#>
################
Get-WebConfigurationProperty /system.applicationhost/applicationpools -name * | select -expand collection | select name -expand processmodel | select name, identitytype, loaduserprofile, maxprocesses, pingingenabled, pingresponsetime, pinginterval, startuptimelimit, shutdowntimelimit

}
return $output
}
Function Computer_ApplicationPoolRecycleSettings
{
param(
$Computername,
$Credential
)
$output=Invoke-Command -Computername $Computername -Credential $Credential -ScriptBlock { Import-Module WebAdministration
################
# SYSKIT
# www.syskit.com
<#
Displays ApplicationPool recycle action settings for all ApplicationPools on the selected Computer. Run on any Computer.
#>
################
<#Get-WebConfigurationProperty /system.applicationhost/applicationpools -name * | select -expand collection |select name -expand recycling |select name ,LogEventOnRecycle, disallowoverlappingrotation, disallowrotationonconfigchange -expand PeriodicRestart | select name ,LogEventOnRecycle, disallowoverlappingrotation, disallowrotationonconfigchange, memory, privatememory, requests, time#>

$var = Get-WebConfigurationProperty /system.applicationhost/applicationpools -name * | select -expand collection 

$allData= @()
$data= @()
$Member = @{
    MemberType = "NoteProperty"
    Force = $true
}

foreach ($v in $var)
{
    $data = new-object psObject
    $data | Add-Member @Member -Name "AppPoolName" -Value $v.Name
    $data | Add-Member @Member -Name "Disallow Overlapping Rotation" -Value $v.recycling.disallowOverlappingRotation
    $data | Add-Member @Member -Name "Disallow Rotationon Configchange" -Value $v.recycling.disallowrotationonconfigchange
    $data | Add-Member @Member -Name "Log Eventon Recycle" -Value $v.recycling.logeventonrecycle    
    $data | Add-Member @Member -Name "Memory" -Value $v.recycling.PeriodicRestart.memory
    $data | Add-Member @Member -Name "Private Memory" -Value $v.recycling.PeriodicRestart.PrivateMemory
    $data | Add-Member @Member -Name "Requests" -Value $v.recycling.PeriodicRestart.requests
    $data | Add-Member @Member -Name "Time" -Value $v.recycling.PeriodicRestart.time
    $data | Add-Member @Member -Name "Schedule Time" -Value $v.recycling.PeriodicRestart.schedule.collection.value

    $data | Add-Member @Member -Name "Schedule: Add Element Names" -Value $v.recycling.PeriodicRestart.schedule.schema.collectionschema.AddElementNames
    $data | Add-Member @Member -Name "Schedule: Allow Duplicates" -Value $v.recycling.PeriodicRestart.schedule.schema.collectionschema.AllowDuplicates
    $data | Add-Member @Member -Name "Schedule: Clear Element Name" -Value $v.recycling.PeriodicRestart.schedule.schema.collectionschema.ClearElementName
    $data | Add-Member @Member -Name "Schedule: Is Merge Append" -Value $v.recycling.PeriodicRestart.schedule.schema.collectionschema.IsMergeAppend
    $data | Add-Member @Member -Name "Schedule: Remove Element Name" -Value $v.recycling.PeriodicRestart.schedule.schema.collectionschema.RemoveElementName
    foreach($att in $v.recycling.schema.attributeschemas)
    {
        $dataExp = new-object psObject
        $dataExp = $data;
        $dataExp| Add-Member @Member -Name "Attribute Name" -Value $att.Name
        $dataExp| Add-Member @Member -Name "Attribute Allow Infinite" -Value $att.AllowInfinite
        $dataExp| Add-Member @Member -Name "Attribute Default Value" -Value $att.DefaultValue
        $dataExp| Add-Member @Member -Name "Attribute Is Case Sensitive" -Value $att.IsCaseSensitive
        $dataExp| Add-Member @Member -Name "Attribute Is Combined Key" -Value $att.IsCombinedKey
        $dataExp| Add-Member @Member -Name "Attribute Is Encrypted" -Value $att.IsEncrypted
        $dataExp| Add-Member @Member -Name "Attribute Is Expanded" -Value $att.IsExpanded
        $dataExp| Add-Member @Member -Name "Attribute Is Required" -Value $att.IsRequired
        $dataExp| Add-Member @Member -Name "Attribute Is Unique Key" -Value $att.IsUniqueKey
        $dataExp| Add-Member @Member -Name "Attribute Type" -Value $att.Type
        $dataExp| Add-Member @Member -Name "Attribute Time Span Format" -Value $att.TimeSpanFormat
        $dataExp
    }
}
}
return $output
}
Function Computer_ApplicationPoolsGeneralSettings
{
param(
$Computername,
$Credential
)
$output=Invoke-Command -Computername $Computername -Credential $Credential -ScriptBlock { Import-Module WebAdministration
################
# SYSKIT
# www.syskit.com
<#
Displays ApplicationPool general settings for all ApplicationPools on the selected Computer. Run on any Computer.
#>
################
Get-WebConfigurationProperty /system.applicationhost/applicationpools -name * | select -expand collection | SELECT name, applicationpoolsid, autoStart, queueLength, managedRuntimeVersion, managedPipelineMode

}
return $output
}
Function Computer_ApplicationPoolTimeoutSettings
{
param(
$Computername,
$Credential
)
$output=Invoke-Command -Computername $Computername -Credential $Credential -ScriptBlock { Import-Module WebAdministration
################
# SYSKIT
# www.syskit.com
<#
Displays ApplicationPool timeout settings for all ApplicationPools on the selected Computer. Run on any Computer.
#>
################
Get-WebConfigurationProperty /system.applicationhost/applicationpools -name * | select -expand collection | select name -expand processmodel | select name, identitytype, idletimeout, idletimeoutaction

}
return $output
}
Function Computer_AspNetSessionSettings
{
param(
$Computername,
$Credential
)
$output=Invoke-Command -Computername $Computername -Credential $Credential -ScriptBlock { Import-Module WebAdministration
################
# SYSKIT
# www.syskit.com
<#
Displays basic AspNet session settings for the selected Computer. Run on any Computer.
#>
################
Get-WebConfigurationProperty /system.webserver/asp/session  -name * | select  allowsessionstate, keepsessionidsecure, max, timeout

}
return $output
}
Function Computer_AspNetSMTPSettings
{
param(
$Computername,
$Credential
)
$output=Invoke-Command -Computername $Computername -Credential $Credential -ScriptBlock { Import-Module WebAdministration
################
# SYSKIT
# www.syskit.com
<#
Displays AspNet SMTP settings for the selected Computer. Run on any Computer.
#>
################
Get-WebConfigurationProperty /system.net/mailSettings/smtp -name network | select  defaultcredentials, host, port, username
}
return $output
}
Function Computer_AspNetTrustLevelSettings
{
param(
$Computername,
$Credential
)
$output=Invoke-Command -Computername $Computername -Credential $Credential -ScriptBlock { Import-Module WebAdministration
################
# SYSKIT
# www.syskit.com
<#
Displays AspNet trust settings for the selected Computer. Run on any Computer.
#>
################
Get-WebConfigurationProperty /system.web/trust -name * | select *
}
return $output
}
Function Computer_AspScriptSettings
{
param(
$Computername,
$Credential
)
$output=Invoke-Command -Computername $Computername -Credential $Credential -ScriptBlock { Import-Module WebAdministration
################
# SYSKIT
# www.syskit.com
<#
Displays general Asp Script info for the selected Computer. Run on any Computer.
#>
################
Get-WebConfigurationProperty /system.webserver/asp -name * | select scriptlanguage, scripterrorsenttobrowser, scripterrormessage -expand limits |select *

}
return $output
}
Function Computer_AnonymousAuthenticationSettings
{
param(
$Computername,
$Credential
)
$output=Invoke-Command -Computername $Computername -Credential $Credential -ScriptBlock { Import-Module WebAdministration
################
# SYSKIT
# www.syskit.com
<#
Displays anonymous authentication settings for the selected Computer. Run on any Computer.
#>
################
get-WebConfigurationProperty -filter /system.WebServer/security/authentication/AnonymousAuthentication -name * | select enabled, logonmethod, username, islocked, overridemode, overridemodeeffective

}
return $output
}
Function Computer_BasicAuthenticationSettings
{
param(
$Computername,
$Credential
)
$output=Invoke-Command -Computername $Computername -Credential $Credential -ScriptBlock { Import-Module WebAdministration
################
# SYSKIT
# www.syskit.com
<#
Displays basic authentication settings for the selected Computer. Run on any Computer.
#>
################
get-WebConfigurationProperty -filter /system.WebServer/security/authentication/BasicAuthentication -name *| select  enabled, relm, defaultlogondomain, logonMethod, islocked, overridemode, overridemodeeffective

}
return $output
}
Function Computer_ClientAuthenticationSettings
{
param(
$Computername,
$Credential
)
$output=Invoke-Command -Computername $Computername -Credential $Credential -ScriptBlock { Import-Module WebAdministration
################
# SYSKIT
# www.syskit.com
<#
Displays client authentication settings for the selected Computer. Run on any Computer.
#>
################
get-WebConfigurationProperty -filter /system.webServer/security/authentication/iisClientCertificateMappingAuthentication  -name * | select  enabled, onetoonecertificatemappingsenabled, manytoonecertificatemappingsenabled, defaultlogondomain, logonmethod, islocked, overridemode, overridemodeeffective

}
return $output
}
Function Computer_WebSettingsDocumentFooterSettings
{
param(
$Computername,
$Credential
)
$output=Invoke-Command -Computername $Computername -Credential $Credential -ScriptBlock { Import-Module WebAdministration
################
# SYSKIT
# www.syskit.com
<#
Lists Websites with its document footer settings. Run on any Computer.
#>
################
Get-WebConfigurationProperty /system.webserver/staticContent  -name * | select defaultdocfooter, isdocfooterfilename, enabledocfooter -expand Collection

}
return $output
}
Function Computer_WebSitesAndApplicationPools
{
param(
$Computername,
$Credential
)
$output=Invoke-Command -Computername $Computername -Credential $Credential -ScriptBlock { Import-Module WebAdministration
################
# SYSKIT
# www.syskit.com
<#
Lists Websites and AppPools that contain them. Run on any Computer.
#>
################
get-website |select name, applicationpool
}
return $output
}
Function Computer_WebSitesBindingSettings
{
param(
$Computername,
$Credential
)
$output=Invoke-Command -Computername $Computername -Credential $Credential -ScriptBlock { Import-Module WebAdministration
################
# SYSKIT
# www.syskit.com
<#
Lists Websites with its binding settings. Run on any Computer.
#>
################
$allData = @()
$test = Get-WebConfigurationProperty /system.applicationhost/sites -name * | select -expand collection | select name -expand bindings
foreach($t in $test)
{
    $allData  += $t |select Name -expand Collection |select Name, Protocol, BindingInformation, SSLFlags
}
$allData
}
return $output
}
Function Computer_WebSitesGeneralSettings
{
param(
$Computername,
$Credential
)
$output=Invoke-Command -Computername $Computername -Credential $Credential -ScriptBlock { Import-Module WebAdministration
################
# SYSKIT
# www.syskit.com
<#
Lists Websites general settings. Run on any Computer.
#>
################
Get-WebConfigurationProperty /system.applicationhost/sites -name * | select -expand collection | select id, name, state, serverAutoStart

}
return $output
}
Function Computer_WebSitesISAPIFilterSettings
{
param(
$Computername,
$Credential
)
$output=Invoke-Command -Computername $Computername -Credential $Credential -ScriptBlock { Import-Module WebAdministration
################
# SYSKIT
# www.syskit.com
<#
Lists Websites ISAPI filter settings. Run on any Computer.
#>
################
Get-WebConfigurationProperty /system.webServer/isapiFilters/filter  -name * | select name, path, enabled, enablecache,  precondition

}
return $output
}
Function Computer_WebSitesNetworkSettings
{
param(
$Computername,
$Credential
)
$output=Invoke-Command -Computername $Computername -Credential $Credential -ScriptBlock { Import-Module WebAdministration
################
# SYSKIT
# www.syskit.com
<#
Lists Websites network settings. Run on any Computer.
#>
################
$test = Get-WebConfigurationProperty /system.applicationhost/sites -name * | select -expand collection | select name -expand limits
$test | select name, maxBandwidth, maxconnections, connectionTimeout, maxUrlSegments
}
return $output
}
Function Computer_WebSiteSourceSettings
{
param(
$Computername,
$Credential
)
$output=Invoke-Command -Computername $Computername -Credential $Credential -ScriptBlock { Import-Module WebAdministration
################
# SYSKIT
# www.syskit.com
<#
Lists Websites source settings. Run on any Computer.
#>
################
get-website |select name, physicalpath, username
}
return $output
}
    Function IIS-Inventory {
        [OutputType([PSCustomObject[]])]
        param(
$Computername,
$Credential
)
$IISData=@{}
$Params=@{Computername=$Computername
        Credential=$credential}
$IISData.AplicationPools=Computer_ApplicationPoolAutostartSettings @Params
$IISData.AplicationPools=Computer_ApplicationPoolFailureSettings @Params
$IISData.AplicationPools=Computer_ApplicationPoolIdentitySettings @Params
$IISData.AplicationPools=Computer_ApplicationPoolOrphanAction @Params
$IISData.AplicationPools=Computer_ApplicationPoolProcessModel @Params
$IISData.AplicationPools=Computer_ApplicationPoolRecycleSettings @Params
$IISData.AplicationPools=Computer_ApplicationPoolsGeneralSettings @Params
$IISData.AplicationPools=Computer_ApplicationPoolTimeoutSettings @Params
$IISData.ASP_NET=Computer_AspNetSessionSettings @Params
$IISData.ASP_NET=Computer_AspNetSMTPSettings @Params
$IISData.ASP_NET=Computer_AspNetTrustLevelSettings @Params
$IISData.ASPSettings=Computer_AspScriptSettings @Params
$IISData.AuthenticationSettings=Computer_AnonymousAuthenticationSettings @Params
$IISData.AuthenticationSettings=Computer_BasicAuthenticationSettings @Params
$IISData.AuthenticationSettings=Computer_ClientAuthenticationSettings @Params
$IISData.WebSites=Computer_WebSettingsDocumentFooterSettings @Params
$IISData.WebSites=Computer_WebSitesAndApplicationPools @Params
$IISData.WebSites=Computer_WebSitesBindingSettings @Params
$IISData.WebSites=Computer_WebSitesGeneralSettings @Params
$IISData.WebSites=Computer_WebSitesISAPIFilterSettings @Params
$IISData.WebSites=Computer_WebSitesNetworkSettings @Params
$IISData.WebSites=Computer_WebSiteSourceSettings @Params

return $IISData
}
