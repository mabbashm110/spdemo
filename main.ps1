npm install xmlhttprequest
Start-Sleep -s 5

node main.js
Start-Sleep -s 5

# Add the reference assembly
Add-Type -AssemblyName System.Web

$diskLocation = "C:\code\files\names.csv"
$diskLocationOne = "c:\code\files\modified.csv"
# Extracted file goes to the diskLocation - main.js
# Open and modify CSV - Email, password, sort
Import-Csv $diskLocation | select Id, Firstname, Lastname, "Email", "Password" | ForEach-Object {
            $_.Email = $_.Firstname + "." + $_.Lastname + "@spr.demo.com"
            $_.Password = [System.Web.Security.Membership]::GeneratePassword(8,2)
            Write-Host $_.Password
            return $_
        } | sort FirstName -Descending | Export-Csv $diskLocationOne 

# Send email, configure SendGrid on Azure - changing emails due to public git repo
Send-MailMessage -To "Mehdi <user@outlook.com>" -From "mo <user@email.com>" -Subject "User data" -Body "Here is the user data requested" -Attachments $diskLocationOne -SmtpServer "mail.outlook.com";