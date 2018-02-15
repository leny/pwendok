function pyebwa --description 'Gource with common params'
	gource --hide dirnames,progress,filenames -r 60 --seconds-per-day 0.25 --auto-skip-seconds 1 -1600x1000 -multi-sampling --title $argv
end
