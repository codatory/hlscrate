for f in $(ls input/); do
  echo "$f"
  base=$(basename "$f")
  mkdir -p "$base/1080p"
  mkdir -p "$base/720p"
  mkdir -p "$base/480p"
  mkdir -p "$base/360p"
  mkdir -p "$base/240p"
  cp template.html "$base/index.html"
  ffmpeg -i "input/$f"\
  -pix_fmt yuv420p -c:a aac -c:v libx264 -x264opts keyint=120:min-keyint=120 -hls_time 4 -preset fast -bufsize 3200k -crf 20 -b:a 192k -maxrate 3200k -profile:v high -vf scale=-2:1080 -master_pl_name master.m3u8 -f hls -hls_playlist_type vod "$base/1080p/1080p.m3u8" \
  -pix_fmt yuv420p -c:a aac -c:v libx264 -x264opts keyint=120:min-keyint=120 -hls_time 4 -preset fast -bufsize 1600k -crf 22 -b:a 128k -maxrate 1600k -profile:v high -vf scale=-2:720 -master_pl_name master.m3u8 -f hls -hls_playlist_type vod "$base/720p/720p.m3u8"\
  -pix_fmt yuv420p -c:a aac -c:v libx264 -x264opts keyint=120:min-keyint=120 -hls_time 4 -preset fast -bufsize 1200k -crf 24 -b:a 96k -maxrate 1200k -profile:v main -vf scale=-2:480 -master_pl_name master.m3u8 -f hls -hls_playlist_type vod "$base/480p/480p.m3u8" \
  -pix_fmt yuv420p -c:a aac -c:v libx264 -x264opts keyint=120:min-keyint=120 -hls_time 4 -preset fast -bufsize 8000k -crf 28 -b:a 64k -maxrate 800k -profile:v main -vf scale=-2:360 -master_pl_name master.m3u8 -f hls -hls_playlist_type vod "$base/360p/360p.m3u8" \
  -pix_fmt yuv420p -c:a aac -c:v libx264 -x264opts keyint=120:min-keyint=120 -hls_time 4 -preset fast -bufsize 400k -crf 32 -b:a 32k -maxrate 400k -profile:v baseline -vf scale=-2:240 -master_pl_name master.m3u8 -f hls -hls_playlist_type vod "$base/240p/240p.m3u8" 

  sed -r 's/1080p.m3u8/1080p\/1080p.m3u8/' $base/1080p/master.m3u8 > $base/master.m3u8
  sed -r 's/720p.m3u8/720p\/720p.m3u8/' $base/720p/master.m3u8 >> $base/master.m3u8
  sed -r 's/480p.m3u8/480p\/480p.m3u8/' $base/480p/master.m3u8 >> $base/master.m3u8
  sed -r 's/360p.m3u8/360p\/360p.m3u8/' $base/360p/master.m3u8 >> $base/master.m3u8
  sed -r 's/240p.m3u8/240p\/240p.m3u8/' $base/240p/master.m3u8 >> $base/master.m3u8
  rm $base/1080p/master.m3u8 $base/720p/master.m3u8 $base/480p/master.m3u8 $base/360p/master.m3u8 $base/240p/master.m3u8
done