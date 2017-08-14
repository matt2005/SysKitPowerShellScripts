
$Files=GCI *.ps1 -Recurse
$functions=@()
Foreach ($file in $files)
{
    $FileData=Get-Content -Raw $File.FullName
    $FunctionData=@'
Function {0}
{{
param(
$Computername,
$Credential
)
$output=Invoke-Command -Computername $Computername -Credential $Credential -ScriptBlock {{ Import-Module WebAdministration
{1}
}}
return $output
}}
'@ -f $File.basename, $FileData

    $FunctionData | Out-file $pwd\IIS.psm1 -Append -encoding unicode
    $Functions+=@{
        Name = $File.BaseName
        Section= ($file.Directory.Name).Replace('.','_').Replace(' ','_')
        }

}
@'
    Function IIS-Inventory {
        [OutputType([PSCustomObject[]])]
        param(
$Computername,
$Credential
)
$IISData=@{}
$Params=@{Computername=$Computername
        Credential=$credential}
'@| Out-file $pwd\IIS.psm1 -Append -encoding unicode
Foreach ($function in $Functions){
    '$IISData.{0}={1} @Params' -f $function.Section,$function.Name| Out-file $pwd\IIS.psm1 -Append -encoding unicode
    }

'
return $IISData
}'| Out-file $pwd\IIS.psm1 -Append -encoding unicode

