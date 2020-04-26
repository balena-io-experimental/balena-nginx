cd /tmp/
if [[ ! -z "${REPO_ZIP_URL}" ]]; then
    wget $REPO_ZIP_URL
    unzip -q master.zip 
    rm master.zip
 if [[ ! -z "${REPO_NAME}" ]]; then   
    yes | cp -r /tmp/$REPO_NAME-master/* /usr/share/nginx/html/
    rm -rf /tmp/$REPO_NAME-master
    echo "blog updated & removed any leftover files"
    else
        echo "You have to provide the name of the repository. Please set the environment variable REPO_NAME to a name of a valid repository"
fi
else
    echo "No repository url has been set. Please set the environment variable REPO_ZIP_URL to a valid url"
fi