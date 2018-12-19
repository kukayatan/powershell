echo "Script usage options"
echo "(1) Display all members of the Local Administrators group"
echo "(2) Add Permanent Admin Rights"
echo "(3) Remove Admin Rights"

$choice = Read-Host "Please enter your option"
			
switch($choice)
{	
	1		
{
			$ComputerIPAddress = read-host "Insert computer ip address"
			[bool]$testconnection = Test-Connection $ComputerIPAddress -Quiet
			if ($testconnection -eq $False)
{
			echo "The IP Address is invalid or the computer is not online."
			echo "Please check the error message above and try again."
			echo "Press any key to continue..."
			[void][System.Console]::ReadKey($true)
			exit
}
	
else
{	
			$objgroup = get-wmiobject win32_group -ComputerName $ComputerIPAddress -Filter "LocalAccount=True AND SID='S-1-5-32-544'" 
			$objgroupnameAdm = $objgroup.name
			$obj_group =[ADSI]"WinNT://$ComputerIPAddress/$objgroupnameAdm,group"
			echo "The members of the local $objgroupnameAdm group on $ComputerIPAddress are:"
			echo "`n"
			$members= @($obj_group.psbase.Invoke("Members")) | foreach{([ADSI]$_).InvokeGet("Adspath") -replace ('WinNT://', '') -replace ('/', '\') | write-host}
			echo "`n"
			echo "Press any key to continue..."
			[void][System.Console]::ReadKey($true)
			exit
}
}		
	

	2
{		
			$ComputerIPAddress = read-host "Insert computer ip address"
			[bool]$testconnection = Test-Connection $ComputerIPAddress -Quiet
			if ($testconnection -eq $False)
{
			echo "The IP Address is invalid or the computer is not online."
			echo "Please chek the error message above and try again."
			echo "Press any key to continue..."
			[void][System.Console]::ReadKey($true)
			exit
}
	
else
		
{	
		
		
			$DomainName = Read-Host "Domain name:"
			$UserName = Read-Host "User name:"
			$AdminGroup = [ADSI]"WinNT://$ComputerIPAddress/Administrators,group"
			$User = [ADSI]"WinNT://$DomainName/$UserName,user"
			$AdminGroup.Add($User.Path)
			$objgroup = get-wmiobject win32_group -ComputerName $ComputerIPAddress -Filter "LocalAccount=True AND SID='S-1-5-32-544'" 
			$objgroupnameAdm = $objgroup.name
			$obj_group =[ADSI]"WinNT://$ComputerIPAddress/$objgroupnameAdm,group"
			
			echo "The members of the local $objgroupnameAdm group on $ComputerIPAddress are:"
			echo "`n"
			$members= @($obj_group.psbase.Invoke("Members")) | foreach{([ADSI]$_).InvokeGet("Adspath") -replace ('WinNT://', '') -replace ('/', '\') | write-host}
			echo "`n"
			echo "Press any key to continue..."
			[void][System.Console]::ReadKey($true)
			exit
}
}
			
			3
{
			$ComputerIPAddress = read-host "Insert computer ip address"
			[bool]$testconnection = Test-Connection $ComputerIPAddress -Quiet
			if ($testconnection -eq $False)
{
			echo "The IP Address is invalid or the computer is not online."
			echo "Please chek the error message above and try again."
			echo "Press any key to continue..."
			[void][System.Console]::ReadKey($true)
			exit
}
	
else
		
{	
			
			
			$DomainName = Read-Host "Domain name:"
			$UserName = Read-Host "User name:"
			$AdminGroup = [ADSI]"WinNT://$ComputerIPAddress/Administrators,group"
			$User = [ADSI]"WinNT://$DomainName/$UserName,user"
			$AdminGroup.Remove($User.Path)
			$objgroup = get-wmiobject win32_group -ComputerName $ComputerIPAddress -Filter "LocalAccount=True AND SID='S-1-5-32-544'" 
			$objgroupnameAdm = $objgroup.name
			$obj_group =[ADSI]"WinNT://$ComputerIPAddress/$objgroupnameAdm,group"
			
			echo "The members of the local $objgroupnameAdm group on $ComputerIPAddress are:"
			echo "`n"
			$members= @($obj_group.psbase.Invoke("Members")) | foreach{([ADSI]$_).InvokeGet("Adspath") -replace ('WinNT://', '') -replace ('/', '\') | write-host}
			echo "`n"
			echo "Press any key to continue..."
			[void][System.Console]::ReadKey($true)
			exit
}
}
}