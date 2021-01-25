# ffmpeg

https://ffmpeg.org/

## trim video

## put all to same frame rate

ffmpeg -i videos/delta.mpg -vcodec mpeg4 -vf fps=30 data/delta.mpg

## concatenate videos

### with a bash for loop
for f in ./videos/*.mpg; do echo "file '$f'" >> list.txt; done
### or with printf
printf "file '%s'\n" ./videos/*.mpg > list.txt

ffmpeg -f concat -safe 0 -i list.txt -c copy data/concatenate.mpg

ffmpeg -f concat -safe 0 -i <(for f in ./videos/*.mpg; do echo "file '$PWD/$f'"; done) -c copy data/concatenate.mpg

## crop video

