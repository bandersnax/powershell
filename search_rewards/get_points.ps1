## Get those points
## Author: Ken Meservy

# Pull a list of words

$response = (Invoke-RestMethod -Uri "https://copylists.com/downloads/words/nouns/nouns.json")

# Pull 30 items out of the response I mistakenly thought that you couldn't do this but I was just
# using the wrong parameter for Get-Random - you can just pipe the noun property right into it without
# explicitly making it an array with $response.noun.split([System.Environment]::NewLine)

$nouns = $response.noun | Get-Random -Count 30

# Loop through the search terms, opening a page in bing for each one

foreach( $search_term in $nouns) {
    Start-Process microsoft-edge:https://www.bing.com/search?q=${search_term}
}


