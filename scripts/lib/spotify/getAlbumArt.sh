pictureCacheDir=~/.cache/spotifyPictureCache

function getAlbmuArt() {
	artUrl=$(playerctl metadata -p spotify --format "{{ mpris:artUrl }}")
	fileName=$(echo $artUrl | grep -Po '.*/\K.*')
	fileNameXpm="$(echo $fileName).xpm"

	if ! [ -f $pictureCacheDir/$fileName ]; then
		wget -O $pictureCacheDir/$fileName $artUrl

		cd $pictureCacheDir
		convert $fileName -resize $imageSize $fileNameXpm
	fi

	if ! [ -f $fileNameXpm ]; then
		cd $pictureCacheDir
		convert $fileName -resize $imageSize $fileNameXpm
	fi

	echo $pictureCacheDir/$fileNameXpm
}

getAlbmuArt
