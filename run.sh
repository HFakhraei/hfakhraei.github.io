export JEKYLL_VERSION=3.8
docker run -p 4000:4000 --name jekyll --rm --volume="$PWD:/srv/jekyll" -it jekyll/jekyll:$JEKYLL_VERSION jekyll serve 
