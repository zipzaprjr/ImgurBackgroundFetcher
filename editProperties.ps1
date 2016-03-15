function displayAlbums{
	for($i=1;$i -le $properties.album.length; $i++){
		Write-Host "$($i): $($properties.album[$($i-1)])"
	}
	Write-Host
}

function removeAlbum{
	Write-Host "0: Take No Action"
	displayAlbums
	$deleteAction = Read-Host "Please indicate which album you would like to delete: "
	if($deleteAction -le $properties.album.length -AND $deleteAction -gt 0){
		Write-Host "Removing $($properties.album[$($deleteAction - 1)])...`n"
		$properties.album = $properties.album -ne $properties.album[($deleteAction - 1)]
		$properties | ConvertTo-Json | Out-File properties.json
	}
}

function addAlbum{
	$addAction = Read-Host "Please indicate the album name you would like to add: "
	$properties.album += $addAction
	$properties | ConvertTo-Json | Out-File properties.json
	Write-Host "Added $($addAction) to file!`n"
}

$exit = 0
$properties
while($exit -eq 0){
	$properties = (Get-Content properties.json) | ConvertFrom-Json
	Write-Host "What album action would you like to do?"
	Write-Host "1: Add"
	Write-Host "2: Remove"
	Write-Host "3: View"
	Write-Host "4: Exit"
	$action = Read-Host "Please specify action with numerical value displayed: "
	Write-Host
	switch ($action){
		1 {
			addAlbum
			break
		}
		2 {
			removeAlbum
			break
		}
		3 {
			displayAlbums
			break
		}
		4 {
			$exit = 1
			break
		}
		default{
			Write-Host "Please use a valid argument.`n"
			break
		}
	}
}