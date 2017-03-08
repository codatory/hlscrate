for /f %%f in ('dir /b input') do (
	echo %%f
	mkdir %%~nf\1080p\
	mkdir %%~nf\720p\
	mkdir %%~nf\480p\
	mkdir %%~nf\320p\
	copy template.m3u8 %%~nf\master.m3u8
	copy template.html %%~nf\index.html
	ffmpeg.exe -i input\%%f -pix_fmt yuv420p -c:a aac -c:v libx264 -x264opts keyint=120:min-keyint=120 -hls_time 4 -preset veryslow -bufsize 4000k -crf 20 -ab 128k -maxrate 3600k -profile:v high -level 4.1 -vf scale=1920:-2 -f hls -hls_playlist_type vod %%~nf\1080p\1080p.m3u8 -pix_fmt yuv420p -c:a aac -c:v libx264 -x264opts keyint=120:min-keyint=120 -hls_time 4 -preset veryslow -bufsize 4000k -crf 22 -ab 96k -maxrate 2400k -profile:v high -level 4.1 -vf scale=1280:-2 -f hls -hls_playlist_type vod %%~nf\720p\720p.m3u8 -pix_fmt yuv420p -c:a aac -c:v libx264 -x264opts keyint=120:min-keyint=120 -hls_time 4 -preset veryslow -bufsize 4000k -crf 24 -ab 64k -maxrate 1200k -profile:v main -level 4.0 -vf scale=512:-2 -f hls -hls_playlist_type vod %%~nf\480p\480p.m3u8 -pix_fmt yuv420p -c:a aac -c:v libx264 -x264opts keyint=120:min-keyint=120 -hls_time 4 -preset veryslow -bufsize 4000k -crf 26 -ab 32k -maxrate 600k -profile:v baseline -level 3.0 -vf scale=384:-2 -f hls -hls_playlist_type vod %%~nf\320p\320p.m3u8
)

