#All credit for the functionality to set desktop background goes to Joel Bennett http://poshcode.org/491
Add-Type @"
using System;
using System.Runtime.InteropServices;
using Microsoft.Win32;
namespace Wallpaper
{
   public enum Style : int
   {
       Tile, Center, Stretch, NoChange
   }
   public class Setter {
      public const int SetDesktopWallpaper = 20;
      public const int UpdateIniFile = 0x01;
      public const int SendWinIniChange = 0x02;
      [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
      private static extern int SystemParametersInfo (int uAction, int uParam, string lpvParam, int fuWinIni);
      public static void SetWallpaper ( string path, Wallpaper.Style style ) {
         SystemParametersInfo( SetDesktopWallpaper, 0, path, UpdateIniFile | SendWinIniChange );
         RegistryKey key = Registry.CurrentUser.OpenSubKey("Control Panel\\Desktop", true);
         switch( style )
         {
            case Style.Stretch :
               key.SetValue(@"WallpaperStyle", "2") ; 
               key.SetValue(@"TileWallpaper", "0") ;
               break;
            case Style.Center :
               key.SetValue(@"WallpaperStyle", "1") ; 
               key.SetValue(@"TileWallpaper", "0") ; 
               break;
            case Style.Tile :
               key.SetValue(@"WallpaperStyle", "1") ; 
               key.SetValue(@"TileWallpaper", "1") ;
               break;
            case Style.NoChange :
               break;
         }
         key.Close();
      }
   }
}
"@
$properties = (Get-Content properties.json) | ConvertFrom-Json
if($properties.album.length -gt 0){
	$randomAlbum = Get-Random -minimum 0 -maximum $properties.album.length
	$url = "https://api.imgur.com/3/gallery/album/$($properties.album[$randomAlbum])/images"
	$auth = @{}
	$auth.Add('Authorization', $properties.clientAuth)
	$response = Invoke-WebRequest $url -Method GET -Headers $auth
	$imageData = $response.Content | ConvertFrom-Json
	if($imageData.data.length -gt 0){
		$randomImage = Get-Random -minimum 0 -maximum $imageData.data.length
		$imageLink = $imageData.data[$randomImage].link
		Invoke-WebRequest $imageLink -OutFile .\backgroundImages\backgroundImage.jpg
		$fullPath = Resolve-Path .\backgroundImages\backgroundImage.jpg
		[Wallpaper.Setter]::SetWallpaper( $fullPath, 0 )
	} else {
		Write-Host "Using $($url) provided no resulting images back, please confirm that the gallery is populated."
	}
} else {
	Write-Host "Please add some albums to the properties file in order to get this app to work."
}