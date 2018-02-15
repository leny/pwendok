function ydlp --description 'download a playlist from youtube'
	youtube-dl --yes-playlist -f '(mp4)[height>=720]'
end
