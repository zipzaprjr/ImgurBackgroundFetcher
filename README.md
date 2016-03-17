This is a project that allows Windows users to fetch a random background from their specified list of albums and make it their background on their desktop. Developed/tested in Windows 10, but may work for Windows 7+. No guarantees on that though.

The project contains the following:
1) backgroundSwapper.ps1 and runbackgroundSwapper.bat
2) editProperties.ps1 and runEditProperties.ps1
3) properties.json
4) backgroundImages/*
5) README.md (this document, not going to explain this one)

1:
The bat script runs the powershell script, which is a script that does all the nifty things that I had wanted it to you. It takes the properties file, which contains the Client ID for the Imgur API and all the albums desired, chooses a random album, then uses the Imgur API to pull all that album's information. Once that is pulled, it takes a random image from the list (currently it assumes that all are an OK resolution or that is what you want, for my purposes the album I am using is all 1920x1080 so it doesn't affect me at all) and downloads it into the backgroundImages folder. Once there, the script then sets that image as your background. The reason I have the backgroundSwapper.bat available is so that I can assign that to a favorite key so it runs that, as there are a few permission issues running powershell scripts off of that which I didn't want to deal with.

2:
This is just a simple tool that allows you to edit the properties.json if you are unfamiliar with json or the syntax it involves. I made it just in case, however it is quite a simple script so don't expect much outside of the ability to ADD/DELETE/VIEW the albums in the file. Note: This does no formatting to the added content, so it doesn't parse out the correct portion of the album's URL to insert it. I will touch more on that when describing the properties file.

3:
Speaking of properties file, this just contains the Client ID for Imgur and all the albums. Please don't abuse the Client ID, it is super easy to get your own and I didn't even provide the corresponding key, so it becomes even less useful. Please don't ruin my nice things :(.
Anyhow, the album ID is the key thing I want to point out. It isn't the full URL to the album, just the ID found after the .../a/*thisPart*. If the incorrect thing is put into this, I didn't error check for that because I am lazy.

4:
This is just the file location that the images are stored. I would recommend if you find an image you like to make a copy and rename it, as the image in the folder (backgroundImage.jpg) will get overwritten on next run of backgroundSwapper.

And that is pretty much it on this simple set of scripts! It doesn't do much validation, error handling, etc. However, if you find an album of awesome background you want to pull images from without having to download a 4000 image file, then this should accomplish that quite well.

Enjoy!
Zipzaprjr