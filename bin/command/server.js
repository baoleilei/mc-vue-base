const chalk = require('chalk')
const shell = require('shelljs')
const { Log, ownDir, cDir } = require('../utils').util
const version = require('../../package.json').version

Log.log(`本地启动 server version is ${chalk.green(version)}`)
Log.log(`set NODE_ENV = development`)

process.env.NODE_ENV = 'development'

Log.green(`启动本地server`)

shell.exec(
  `node ${ownDir(
    'node_modules/webpack-dev-server/bin/webpack-dev-server.js'
  )} --inline --progress --config ${cDir('webpack.dev.conf.js')} --color`
)
