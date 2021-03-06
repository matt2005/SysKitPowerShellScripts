Function Computer_ApplicationPoolAutostartSettings
{
    param(
        $Computername,
        $Credential
    )
    $output = Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
        Import-Module -Name WebAdministration
        ################
        # SYSKIT
        # www.syskit.com
        <#
                Displays ApplicationPool autostart settings for all ApplicationPools on the selected Computer. Run on any Computer.
        #>
        ################
        Get-WebConfigurationProperty /system.applicationhost/applicationpools -name * |
        Select-Object -ExpandProperty collection |
        Select-Object -Property name, startmode, enable32BitAppOnWin64, managedRuntimeVersion, managedRuntimeLoader, enableConfigurationOverride, CLRConfigFile, passAnonymousToken, state, Attributes, ChildElements, ElementTagName, Methods
    }
    return $output
}
Function Computer_ApplicationPoolFailureSettings
{
    param(
        $Computername,
        $Credential
    )
    $output = Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
        Import-Module -Name WebAdministration
        ################
        # SYSKIT
        # www.syskit.com
        <#
                Displays ApplicationPool rapid failure settings for all ApplicationPools on the selected Computer. Run on any Computer.
        #>
        ################
        Get-WebConfigurationProperty /system.applicationhost/applicationpools -name * |
        Select-Object -ExpandProperty collection |
        Select-Object -Property name -ExpandProperty Failure |
        Select-Object -Property name, RapidFailProtection, RapidFailProtectionInterval, RapidFailProtectionMaxCrashes, autoShutdownExe, autoShutdowParams
    }
    return $output
}
Function Computer_ApplicationPoolIdentitySettings
{
    param(
        $Computername,
        $Credential
    )
    $output = Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
        Import-Module -Name WebAdministration
        ################
        # SYSKIT
        # www.syskit.com
        <#
                Displays ApplicationPool identity settings for all ApplicationPools on the selected Computer. Run on any Computer.
        #>
        ################
        Get-WebConfigurationProperty /system.applicationhost/applicationpools -name * |
        Select-Object -ExpandProperty collection |
        Select-Object -Property name -ExpandProperty processmodel |
        Select-Object -Property name, identitytype, loaduserprofile, username
    }
    return $output
}
Function Computer_ApplicationPoolOrphanAction
{
    param(
        $Computername,
        $Credential
    )
    $output = Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
        Import-Module -Name WebAdministration
        ################
        # SYSKIT
        # www.syskit.com
        <#
                Displays ApplicationPool Orphan action settings for all ApplicationPools on the selected Computer. Run on any Computer.
        #>
        ################
        Get-WebConfigurationProperty /system.applicationhost/applicationpools -name * |
        Select-Object -ExpandProperty collection |
        Select-Object -Property name -ExpandProperty Failure |
        Select-Object -Property name, OrphanActionExe, OrphanActionParams, OrphanWorkerProcess
    }
    return $output
}
Function Computer_ApplicationPoolProcessModel
{
    param(
        $Computername,
        $Credential
    )
    $output = Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
        Import-Module -Name WebAdministration
        ################
        # SYSKIT
        # www.syskit.com
        <#
                Displays ApplicationPool ping settings and startup and shutdown time limits for all ApplicationPools on the selected Computer. Run on any Computer.
        #>
        ################
        Get-WebConfigurationProperty /system.applicationhost/applicationpools -name * |
        Select-Object -ExpandProperty collection |
        Select-Object -Property name -ExpandProperty processmodel |
        Select-Object -Property name, identitytype, loaduserprofile, maxprocesses, pingingenabled, pingresponsetime, pinginterval, startuptimelimit, shutdowntimelimit
    }
    return $output
}
Function Computer_ApplicationPoolRecycleSettings
{
    param(
        $Computername,
        $Credential
    )
    $output = Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
        Import-Module -Name WebAdministration
        ################
        # SYSKIT
        # www.syskit.com
        <#
                Displays ApplicationPool recycle action settings for all ApplicationPools on the selected Computer. Run on any Computer.
        #>
        ################
        <#Get-WebConfigurationProperty /system.applicationhost/applicationpools -name * | select -expand collection |select name -expand recycling |select name ,LogEventOnRecycle, disallowoverlappingrotation, disallowrotationonconfigchange -expand PeriodicRestart | select name ,LogEventOnRecycle, disallowoverlappingrotation, disallowrotationonconfigchange, memory, privatememory, requests, time#>

        $var = Get-WebConfigurationProperty /system.applicationhost/applicationpools -name * | Select-Object -ExpandProperty collection 

        $allData = @()
        $data = @()
        $Member = @{
            MemberType = 'NoteProperty'
            Force      = $true
        }

        foreach ($v in $var)
        {
            $data = New-Object -TypeName psObject
            $data | Add-Member @Member -Name 'AppPoolName' -Value $v.Name
            $data | Add-Member @Member -Name 'Disallow Overlapping Rotation' -Value $v.recycling.disallowOverlappingRotation
            $data | Add-Member @Member -Name 'Disallow Rotationon Configchange' -Value $v.recycling.disallowrotationonconfigchange
            $data | Add-Member @Member -Name 'Log Eventon Recycle' -Value $v.recycling.logeventonrecycle    
            $data | Add-Member @Member -Name 'Memory' -Value $v.recycling.PeriodicRestart.memory
            $data | Add-Member @Member -Name 'Private Memory' -Value $v.recycling.PeriodicRestart.PrivateMemory
            $data | Add-Member @Member -Name 'Requests' -Value $v.recycling.PeriodicRestart.requests
            $data | Add-Member @Member -Name 'Time' -Value $v.recycling.PeriodicRestart.time
            $data | Add-Member @Member -Name 'Schedule Time' -Value $v.recycling.PeriodicRestart.schedule.collection.value

            $data | Add-Member @Member -Name 'Schedule: Add Element Names' -Value $v.recycling.PeriodicRestart.schedule.schema.collectionschema.AddElementNames
            $data | Add-Member @Member -Name 'Schedule: Allow Duplicates' -Value $v.recycling.PeriodicRestart.schedule.schema.collectionschema.AllowDuplicates
            $data | Add-Member @Member -Name 'Schedule: Clear Element Name' -Value $v.recycling.PeriodicRestart.schedule.schema.collectionschema.ClearElementName
            $data | Add-Member @Member -Name 'Schedule: Is Merge Append' -Value $v.recycling.PeriodicRestart.schedule.schema.collectionschema.IsMergeAppend
            $data | Add-Member @Member -Name 'Schedule: Remove Element Name' -Value $v.recycling.PeriodicRestart.schedule.schema.collectionschema.RemoveElementName
            foreach($att in $v.recycling.schema.attributeschemas)
            {
                $dataExp = New-Object psObject
                $dataExp = $data
                $dataExp| Add-Member @Member -Name 'Attribute Name' -Value $att.Name
                $dataExp| Add-Member @Member -Name 'Attribute Allow Infinite' -Value $att.AllowInfinite
                $dataExp| Add-Member @Member -Name 'Attribute Default Value' -Value $att.DefaultValue
                $dataExp| Add-Member @Member -Name 'Attribute Is Case Sensitive' -Value $att.IsCaseSensitive
                $dataExp| Add-Member @Member -Name 'Attribute Is Combined Key' -Value $att.IsCombinedKey
                $dataExp| Add-Member @Member -Name 'Attribute Is Encrypted' -Value $att.IsEncrypted
                $dataExp| Add-Member @Member -Name 'Attribute Is Expanded' -Value $att.IsExpanded
                $dataExp| Add-Member @Member -Name 'Attribute Is Required' -Value $att.IsRequired
                $dataExp| Add-Member @Member -Name 'Attribute Is Unique Key' -Value $att.IsUniqueKey
                $dataExp| Add-Member @Member -Name 'Attribute Type' -Value $att.Type
                $dataExp| Add-Member @Member -Name 'Attribute Time Span Format' -Value $att.TimeSpanFormat
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
    $output = Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
        Import-Module WebAdministration
        ################
        # SYSKIT
        # www.syskit.com
        <#
                Displays ApplicationPool general settings for all ApplicationPools on the selected Computer. Run on any Computer.
        #>
        ################
        Get-WebConfigurationProperty /system.applicationhost/applicationpools -name * |
        Select-Object -ExpandProperty collection |
        Select-Object name, applicationpoolsid, autoStart, queueLength, managedRuntimeVersion, managedPipelineMode
    }
    return $output
}
Function Computer_ApplicationPoolTimeoutSettings
{
    param(
        $Computername,
        $Credential
    )
    $output = Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
        Import-Module WebAdministration
        ################
        # SYSKIT
        # www.syskit.com
        <#
                Displays ApplicationPool timeout settings for all ApplicationPools on the selected Computer. Run on any Computer.
        #>
        ################
        Get-WebConfigurationProperty /system.applicationhost/applicationpools -name * |
        Select-Object -ExpandProperty collection |
        Select-Object name -ExpandProperty processmodel |
        Select-Object name, identitytype, idletimeout, idletimeoutaction
    }
    return $output
}
Function Computer_AspNetSessionSettings
{
    param(
        $Computername,
        $Credential
    )
    $output = Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
        Import-Module WebAdministration
        ################
        # SYSKIT
        # www.syskit.com
        <#
                Displays basic AspNet session settings for the selected Computer. Run on any Computer.
        #>
        ################
        Get-WebConfigurationProperty /system.webserver/asp/session  -name * | Select-Object  allowsessionstate, keepsessionidsecure, max, timeout
    }
    return $output
}
Function Computer_AspNetSMTPSettings
{
    param(
        $Computername,
        $Credential
    )
    $output = Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
        Import-Module WebAdministration
        ################
        # SYSKIT
        # www.syskit.com
        <#
                Displays AspNet SMTP settings for the selected Computer. Run on any Computer.
        #>
        ################
        Get-WebConfigurationProperty /system.net/mailSettings/smtp -name network | Select-Object  defaultcredentials, host, port, username
    }
    return $output
}
Function Computer_AspNetTrustLevelSettings
{
    param(
        $Computername,
        $Credential
    )
    $output = Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
        Import-Module WebAdministration
        ################
        # SYSKIT
        # www.syskit.com
        <#
                Displays AspNet trust settings for the selected Computer. Run on any Computer.
        #>
        ################
        Get-WebConfigurationProperty /system.web/trust -name * | Select-Object *
    }
    return $output
}
Function Computer_AspScriptSettings
{
    param(
        $Computername,
        $Credential
    )
    $output = Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
        Import-Module WebAdministration
        ################
        # SYSKIT
        # www.syskit.com
        <#
                Displays general Asp Script info for the selected Computer. Run on any Computer.
        #>
        ################
        Get-WebConfigurationProperty /system.webserver/asp -name * |
        Select-Object scriptlanguage, scripterrorsenttobrowser, scripterrormessage -ExpandProperty limits |
        Select-Object *
    }
    return $output
}
Function Computer_AnonymousAuthenticationSettings
{
    param(
        $Computername,
        $Credential
    )
    $output = Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
        Import-Module WebAdministration
        ################
        # SYSKIT
        # www.syskit.com
        <#
                Displays anonymous authentication settings for the selected Computer. Run on any Computer.
        #>
        ################
        get-WebConfigurationProperty -filter /system.WebServer/security/authentication/AnonymousAuthentication -name * | Select-Object enabled, logonmethod, username, islocked, overridemode, overridemodeeffective
    }
    return $output
}
Function Computer_BasicAuthenticationSettings
{
    param(
        $Computername,
        $Credential
    )
    $output = Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
        Import-Module WebAdministration
        ################
        # SYSKIT
        # www.syskit.com
        <#
                Displays basic authentication settings for the selected Computer. Run on any Computer.
        #>
        ################
        get-WebConfigurationProperty -filter /system.WebServer/security/authentication/BasicAuthentication -name *| Select-Object  enabled, relm, defaultlogondomain, logonMethod, islocked, overridemode, overridemodeeffective
    }
    return $output
}
Function Computer_ClientAuthenticationSettings
{
    param(
        $Computername,
        $Credential
    )
    $output = Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
        Import-Module WebAdministration
        ################
        # SYSKIT
        # www.syskit.com
        <#
                Displays client authentication settings for the selected Computer. Run on any Computer.
        #>
        ################
        get-WebConfigurationProperty -filter /system.webServer/security/authentication/iisClientCertificateMappingAuthentication  -name * | Select-Object  enabled, onetoonecertificatemappingsenabled, manytoonecertificatemappingsenabled, defaultlogondomain, logonmethod, islocked, overridemode, overridemodeeffective
    }
    return $output
}
Function Computer_WebSettingsDocumentFooterSettings
{
    param(
        $Computername,
        $Credential
    )
    $output = Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
        Import-Module WebAdministration
        ################
        # SYSKIT
        # www.syskit.com
        <#
                Lists Websites with its document footer settings. Run on any Computer.
        #>
        ################
        Get-WebConfigurationProperty /system.webserver/staticContent  -name * | Select-Object defaultdocfooter, isdocfooterfilename, enabledocfooter -ExpandProperty Collection
    }
    return $output
}
Function Computer_WebSitesAndApplicationPools
{
    param(
        $Computername,
        $Credential
    )
    $output = Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
        Import-Module WebAdministration
        ################
        # SYSKIT
        # www.syskit.com
        <#
                Lists Websites and AppPools that contain them. Run on any Computer.
        #>
        ################
        get-website |Select-Object name, applicationpool
    }
    return $output
}
Function Computer_WebSitesBindingSettings
{
    param(
        $Computername,
        $Credential
    )
    $output = Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
        Import-Module WebAdministration
        ################
        # SYSKIT
        # www.syskit.com
        <#
                Lists Websites with its binding settings. Run on any Computer.
        #>
        ################
        $allData = @()
        $test = Get-WebConfigurationProperty /system.applicationhost/sites -name * |
        Select-Object -ExpandProperty collection |
        Select-Object name -ExpandProperty bindings
        foreach($t in $test)
        {
            $allData  += $t |
            Select-Object Name -ExpandProperty Collection |
            Select-Object Name, Protocol, BindingInformation, SSLFlags
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
    $output = Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
        Import-Module WebAdministration
        ################
        # SYSKIT
        # www.syskit.com
        <#
                Lists Websites general settings. Run on any Computer.
        #>
        ################
        Get-WebConfigurationProperty /system.applicationhost/sites -name * |
        Select-Object -ExpandProperty collection |
        Select-Object id, name, state, serverAutoStart
    }
    return $output
}
Function Computer_WebSitesISAPIFilterSettings
{
    param(
        $Computername,
        $Credential
    )
    $output = Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
        Import-Module WebAdministration
        ################
        # SYSKIT
        # www.syskit.com
        <#
                Lists Websites ISAPI filter settings. Run on any Computer.
        #>
        ################
        Get-WebConfigurationProperty /system.webServer/isapiFilters/filter  -name * | Select-Object name, path, enabled, enablecache, precondition
    }
    return $output
}
Function Computer_WebSitesNetworkSettings
{
    param(
        $Computername,
        $Credential
    )
    $output = Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
        Import-Module WebAdministration
        ################
        # SYSKIT
        # www.syskit.com
        <#
                Lists Websites network settings. Run on any Computer.
        #>
        ################
        $test = Get-WebConfigurationProperty /system.applicationhost/sites -name * |
        Select-Object -ExpandProperty collection |
        Select-Object name -ExpandProperty limits
        $test | Select-Object name, maxBandwidth, maxconnections, connectionTimeout, maxUrlSegments
    }
    return $output
}
Function Computer_WebSiteSourceSettings
{
    param(
        $Computername,
        $Credential
    )
    $output = Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
        Import-Module WebAdministration
        ################
        # SYSKIT
        # www.syskit.com
        <#
                Lists Websites source settings. Run on any Computer.
        #>
        ################
        get-website |Select-Object name, physicalpath, username
    }
    return $output
}
Function Get-IISConfiguration
{
    [OutputType([PSCustomObject[]])]
    param(
        $Computername,
        $Credential
    )
    $output = Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
        Import-Module WebAdministration
        $ServerConfiguration = @{
            ApplicationHost = [xml](Get-Content "$env:windir\System32\inetsrv\config\applicationHost.config")
            Administration  = [xml](Get-Content "$env:windir\System32\inetsrv\config\administration.config")
            Redirection     = [xml](Get-Content "$env:windir\System32\inetsrv\config\redirection.config")
            Sites           = @{}
        }
        Foreach ($site in $ServerConfiguration.ApplicationHost.configuration.'system.applicationhost'.sites.site)
        {
            $ServerConfiguration.Sites.$($site.Name) = @{}
            $ServerConfiguration.Sites.$($site.Name).WebApplications = @{}
            $WebApplications = ($site.application | Sort-Object Path)
            Foreach ($WebApplication in $WebApplications)
            {
                $WebApplicationPath = ($WebApplication.Path -replace '^/', '').Replace('/','\')
                $WebApplicationSplit = $WebApplicationPath.split('\')
                $RootWebApp = $WebApplicationSplit[0]
                IF ($WebApplicationSplit.count -eq 1)
                {
                    $ServerConfiguration.Sites.$($site.Name).WebApplications.$RootWebApp = @{}
                    $WebApplicationRoot = $ServerConfiguration.Sites.$($site.Name).WebApplications.$RootWebApp
                }
                Else 
                {
                    $WebApplicationRoot = $ServerConfiguration.Sites.$($site.Name).WebApplications.$RootWebApp
                    Foreach ($item in $WebApplicationSplit)
                    {
                        If ($item -eq $RootWebApp){
                         Continue
                        }
                        IF (-not $WebApplicationRoot.$item){
                        $WebApplicationRoot.$item=@{}
                        }
                        $WebApplicationRoot = $WebApplicationRoot.$item
                    }
                }
                $WebApplicationRoot.WebConfig = @{
                    Path = $('IIS:\Sites\{0}\{1}' -f $site.Name, $WebApplicationPath)
                }
                $WebApplicationRoot.WebConfig.Data = [xml](Get-Content -Raw -Path $(Get-WebConfigFile -PSPath $WebApplicationRoot.WebConfig.Path ))
            }
        }

        Return $ServerConfiguration
    }
    Return $output
}
Function Get-IISInventory 
{
    [OutputType([PSCustomObject[]])]
    param(
        $Computername,
        $Credential
    )
    $IISData = @{
        ApplicationPools       = @{}
        ASP_NET                = @{}
        ASPScript              = @{}
        AuthenticationSettings = @{}
        WebSites               = @{}
    }
    $Params = @{
        Computername = $Computername
        Credential   = $Credential
    }
    $IISData.ApplicationPools.AutoStartSettings = Computer_ApplicationPoolAutostartSettings @Params
    $IISData.ApplicationPools.FailureSettings = Computer_ApplicationPoolFailureSettings @Params
    $IISData.ApplicationPools.IdentitySettings = Computer_ApplicationPoolIdentitySettings @Params
    $IISData.ApplicationPools.OrphanAction = Computer_ApplicationPoolOrphanAction @Params
    $IISData.ApplicationPools.ProcessModel = Computer_ApplicationPoolProcessModel @Params
    $IISData.ApplicationPools.RecycleSettings = Computer_ApplicationPoolRecycleSettings @Params
    $IISData.ApplicationPools.GeneralSettings = Computer_ApplicationPoolsGeneralSettings @Params
    $IISData.ApplicationPools.TimeoutSettings = Computer_ApplicationPoolTimeoutSettings @Params
    $IISData.ASP_NET.SessionSettings = Computer_AspNetSessionSettings @Params
    $IISData.ASP_NET.SMTPSettings = Computer_AspNetSMTPSettings @Params
    $IISData.ASP_NET.TrustLevelSettings = Computer_AspNetTrustLevelSettings @Params
    $IISData.ASPScript.Settings = Computer_AspScriptSettings @Params
    $IISData.AuthenticationSettings.Anonymous = Computer_AnonymousAuthenticationSettings @Params
    $IISData.AuthenticationSettings.Basic = Computer_BasicAuthenticationSettings @Params
    $IISData.AuthenticationSettings.Client = Computer_ClientAuthenticationSettings @Params
    $IISData.WebSites.DocumentFooterSettings = Computer_WebSettingsDocumentFooterSettings @Params
    $IISData.WebSitesAndApplicationPools = Computer_WebSitesAndApplicationPools @Params
    $IISData.WebSites.BindingSettings = Computer_WebSitesBindingSettings @Params
    $IISData.WebSites.GeneralSettings = Computer_WebSitesGeneralSettings @Params
    $IISData.WebSites.ISAPIFilterSettings = Computer_WebSitesISAPIFilterSettings @Params
    $IISData.WebSites.NetworkSettings = Computer_WebSitesNetworkSettings @Params
    $IISData.WebSites.SourceSettings = Computer_WebSiteSourceSettings @Params

    return $IISData
}
Export-ModuleMember -Function Get-IISInventory, Get-IISConfiguration