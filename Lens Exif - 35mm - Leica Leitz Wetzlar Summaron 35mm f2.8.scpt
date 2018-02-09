set lens to "Leica Leitz Wetzlar Summaron 35mm f2.8"
set focalLength to "35 mm"
set defaultAperture to 2.8
set maxAperture to 2.8

set theRespondedAperture to the text returned of ¬
	(display dialog ¬
		"What's the aperture value?" default answer defaultAperture ¬
		with icon note buttons {"Cancel", "Continue"} default button "Continue")

tell application "Capture One 11"
	set selectedVariants to (get selected variants)
	repeat with i from 1 to number of items in selectedVariants
		set this_item to item i of selectedVariants
		set theID to id of (parent image of this_item)
		do shell script "/usr/local/bin/exiftool -overwrite_original_in_place -preserve " & ¬
			"-lens=" & quoted form of lens & " -focallength=" & quoted form of focalLength & ¬
			" -EXIF:MaxApertureValue=" & maxAperture & ¬
			" -EXIF:ApertureValue=" & theRespondedAperture & ¬
			" -fnumber=" & theRespondedAperture & ¬
			" " & quoted form of theID
		--Remove the log statement when no longer needed. Used just for demo
		--log theID
		--do shell script "touch " & quoted form of theID
		reload metadata this_item
	end repeat
end tell