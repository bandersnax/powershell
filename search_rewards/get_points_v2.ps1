# Get User Consent (Optional but Recommended)
$confirm = Read-Host "This script opens Bing searches in your default browser. Continue? (y/n): "
if ($confirm -ne "y") {
  Exit
}

# Function to Detect Default Browser (Improved Logic)
function Get-DefaultBrowser {
  $defaultBrowserPath = (Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\Shell\Associations\Classes\http\shell\open\command").(Default)
  if ($defaultBrowserPath -match "chrome\.exe") {
    return "chrome"
  } elseif ($defaultBrowserPath -match "firefox\.exe") {
    return "firefox"
  } else {
    # Handle cases where the default browser isn't Chrome or Firefox
    # You can add checks for other browsers or prompt the user here
    Write-Warning "Default browser detection might be incomplete. Using fallback browser."
    return "iexplore"  # Assuming Internet Explorer as a fallback
  }
}

# Get Default Browser
$defaultBrowser = Get-DefaultBrowser

# Loop through Search Terms and Open in Default Browser
foreach ($searchTerm in (Invoke-RestMethod -Uri "https://copylists.com/downloads/words/nouns/nouns.json").noun | Get-Random -Count 30) {
  Start-Process "$defaultBrowser:https://www.bing.com/search?q=${searchTerm}" -Wait
  Start-Sleep -Seconds 2  # Add a small delay to simulate user behavior (optional)
}
