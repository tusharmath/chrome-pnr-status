should = require 'should'
rjs = require 'requirejs'
rjs.config
	baseUrl: './bin/debug/content/js/app'
	nodeRequire: require

global.requirejs = (items...) -> rjs i for i in items
	
module.exports = {}