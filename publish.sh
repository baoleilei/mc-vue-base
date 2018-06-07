#!/bin/bash
NODE_VERSION="v8.11.2"
ENV="testing"
while getopts "v:e:" arg #选项后面的冒号表示该选项需要参数
do
        case $arg in
             v)
                VERSION=$OPTARG
                ;;
             e)
                ENV=$OPTARG
                ;;
             ?)  #当有不认识的选项的时候arg为?
            echo "含有未知参数"
        exit 1
        ;;
        esac
done

echo $NODE_VERSION $ENV

# check command
command_exists () {
    type "$1" >/dev/null 2>&1;
}

# check node version
def_nodeVer() {
    source ~/.nvm/nvm.sh
    local node_version="$(nvm version)"
    local def_version="$1"

    if [ "$node_version" != "$def_version" ]; then
        nvm install "$def_version"
        nvm alias default "$def_version"
    fi
}
# install node 
if ! [ -x "$(command -v nvm)" ]; then
        def_nodeVer v8.11.2
    else
        curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
        def_nodeVer v8.11.2
fi

# set var
WEBROOT="/data/web/"
ENVDIR=""
PJ_NAME="vuebasepj"
SRC="./dist"
NODE_CMD=""

# env?
case $ENV in
     "testing")
        ENVDIR="testspa/"
        NODE_CMD="test.js"
        ;;
     "production")
        ENVDIR="spa/"
        NODE_CMD="build.js"
        ;;
     *)
        ENVDIR="spa/"
        NODE_CMD="build.js"
        ;;
esac

# relese dir
DIST=${WEBROOT}${ENVDIR}${PJ_NAME}


# install cnpm 
if ! [ -x "$(command -v cnpm)" ]; then
    npm install -g cnpm --registry=https://registry.npm.taobao.org
fi
# install node module
cnpm install
# build
node bin/command/${NODE_CMD}
# cp dist file
# cp -r ${SRC} ${DIST}

