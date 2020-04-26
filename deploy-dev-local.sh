# This script is used to build the jekyll blog part of the website and update the git repository
# It then logs me into balena (the webserver) in order to run manually another script which downloads the updated website to the server.


export J_OUTPUT=/Users/odys/Github/odyslam.github.io/blog/
export REPO=/Users/odys/Github/odyslam.github.io
export DEV_UUID=b6811f2

# If the jekyll theme uses bundler, uncomment the line bellow:
# bundle exec jekyll build -d $J_OUTPUT

# If the jekyll theme doesn't use bundler, uncomment the line bellow:
# jekyll build -d $J_OUTPUT

if [ $? -eq 0 ]; then
    cd $REPO
    git add -A && git commit --signoff -m "$1" 
    if [ $? -eq 0 ]; then
        git push && echo "new post pushed to github!"
        CONTAINER_ID=$(ssh -Tp 22222 root@$DEV_UUID.local <<< 'balena-engine ps' | grep 'nginx' | awk '{print $1}')
        ssh -Tp 22222 root@b6811f2.local "balena-engine exec $CONTAINER_ID /bin/sh /update-blog.sh"
    else
        echo "no commit message, deploy is aborted.."    
    fi
else
    echo "Jekyll build failed, please try again"
fi


