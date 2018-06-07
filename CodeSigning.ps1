

<#
.SYNOPSIS
 SelfSignedCertificate Demo


#>


# Remove-Item –Path Cert:\LocalMachine\My\DE53B1272E43C14545A448FB892F7C07A217A765



# Step-1
New-SelfSignedCertificate -CertStoreLocation cert:\localmachine\my `
-Subject "GitHub MyPowerShell" `
-KeyAlgorithm RSA `
-KeyLength 2048 `
-Provider "Microsoft Enhanced RSA and AES Cryptographic Provider" `
-KeyExportPolicy Exportable `
-KeyUsage DigitalSignature `
-Type CodeSigningCert

# Step-2
$password = Read-host "Please Enter a Password to Export"
$CertPassword = ConvertTo-SecureString -String $password -Force –AsPlainText
Export-PfxCertificate -Cert "cert:\LocalMachine\My\DE53B1272E43C14545A448FB892F7C07A217A765" -FilePath "C:\Temp\ExportedCert.pfx" -Password $CertPassword

# Step-3
Install Exported Cert on Computer

# Signing Script File
$Cert = (Get-ChildItem –Path cert:\LocalMachine\My\DE53B1272E43C14545A448FB892F7C07A217A765)
Set-AuthenticodeSignature -FilePath "C:\ScriptExamples\HelloWorld.ps1" -Certificate $Cert


<#
SignerCertificate                         Status                                                             Path                                                             
-----------------                         ------                                                             ----                                                             
DE53B1272E43C14545A448FB892F7C07A217A765  Valid                                                              HelloWorld.ps1


#>


# Execute following command to check your current execution policy

Get-ExecutionPolicy -List

<#
        Scope ExecutionPolicy
        ----- ---------------
MachinePolicy       Undefined
   UserPolicy       Undefined
      Process       Undefined
  CurrentUser       Undefined
 LocalMachine    RemoteSigned

 #>

# Set-ExecutionPolicy -Scope LocalMachine -ExecutionPolicy RemoteSigned -Force
Set-ExecutionPolicy -Scope LocalMachine -ExecutionPolicy AllSigned -Force


# Run your CodeSigned test script, to make sure it runs under AllSigned Execution Policy

