To script the installation of a package from SCCM to a client machine, you can use PowerShell. You'll need to know the package ID and the deployment ID associated with the package you want to install. Here's a step-by-step guide on how to do this:

Get the Package and Deployment Information:

First, you need to find the package ID and deployment ID for the package you want to install. You can obtain this information from the SCCM console or by using PowerShell. To get the package information, use the following PowerShell commands:

powershell
Copy code
Import-Module ($Env:SMS_ADMIN_UI_PATH.Substring(0, $Env:SMS_ADMIN_UI_PATH.Length-5) + '\ConfigurationManager.psd1')

# Connect to the SCCM site
$SiteCode = "ABC"  # Replace with your SCCM site code
Set-Location "$($SiteCode):\"

# Get the package ID
$Package = Get-CMPackage -Name "YourPackageName"  # Replace with the name of your package
$PackageID = $Package.PackageID

# Get the deployment ID
$Deployment = Get-CMDeployment -PackageID $PackageID
$DeploymentID = $Deployment.DeploymentID
Trigger the Installation:

Once you have the package ID and deployment ID, you can trigger the installation on the client machine. You can use the Start-CMDistributionPoint cmdlet for this purpose. Here's an example:

powershell
Copy code
Invoke-CMDistributionPoint -PackageID $PackageID -DeploymentID $DeploymentID -Action Install -DeviceName "ClientComputerName"
Replace $PackageID with the package ID you obtained.
Replace $DeploymentID with the deployment ID you obtained.
Replace "ClientComputerName" with the name of the target client machine where you want to install the package.
Wait for Installation:

The installation may take some time, depending on the size of the package and the client's configuration. You can monitor the installation progress through SCCM's console or use PowerShell to check the installation status on the client machine.

To check the installation status on the client machine, you can use the following PowerShell command:

powershell
Copy code
Get-CMSoftwareDistribution -PackageID $PackageID -DeploymentID $DeploymentID -DeviceName "ClientComputerName"
This command will give you information about the deployment status on the specified client.

Please make sure you have the necessary permissions in SCCM to perform these actions, and thoroughly test your script in a controlled environment before deploying it in a production setting. Also, consider error handling and logging to ensure the script behaves as expected.
