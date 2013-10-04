matchdep = require 'matchdep'


grunt_config = 


	opt: 
		debugPath: './bin/debug',
		releasePath: './bin/release'

	release: options: npm: false

	coffee:
		debug: {
			expand: true,
			#flatten: true,
			cwd: './src/',
			src: [
				'content/js/app/*.coffee'
				'background.coffee'
				'content/js/app.coffee'
			],
			dest: '<%= opt.debugPath%>',
			ext: '.js'
		}

	jade: 
		debug:
			options: data: debug: true
			files: [
				"<%= opt.debugPath%>/window.html" : "./src/views/window.jade"
			,
				"<%= opt.debugPath%>/sandboxed.html" : "./src/views/sandboxed.jade"
			]
		release:
			options: data: debug: false
			files: [
				"<%= opt.debugPath%>/window.html" : "./src/views/window.jade"
			,
				"<%= opt.debugPath%>/sandboxed.html" : "./src/views/sandboxed.jade"
			]
		
	
	copy:
		debug: files: [
				expand: true
				cwd: './src/'
				src: [
					'content/css/**'
					'content/fonts/**'
					'content/img/**'
					'content/js/lib/**'
				]
				dest: '<%= opt.debugPath%>/'
			]

	"string-replace": debug:
		options: 
			replacements:[
					pattern: "APPLICATION_VERSION"
					replacement: "<%= pkg.version %>"
				,
					pattern: "APPLICATION_NAME"
					replacement: "<%= pkg.name %>"
				]
		files: '<%= opt.debugPath%>/manifest.json': './src/manifest.json'
	
	less: 
		debug: files: "<%= opt.debugPath%>/content/css/styles.css" : "./src/less/styles.less"
	
	clean: debug: ["<%= opt.debugPath %>"]

	watch:
		binupdate: files: ["<%= opt.debugPath%>/**"], options: livereload: 1337
		jade:files: "./src/views/**", tasks: ["jade:debug"]
		less:files: "./src/less/**", tasks: ["less:debug"]
		content:
			files: ["./src/content/**"],tasks: ["copy:debug"]
		manifest:
			files: ["./src/manifest.json"], tasks: ["string-replace:debug"]
		coffee:files: "./src/**/*.coffee", tasks: ["coffee"]


	crx:
		production:
			src: '<%= opt.debugPath%>'
			dest: "<%= opt.releasePath%>/PnrLive.<%= pkg.version%>.crx"
			privateKey: "./chrome-apps.pem"
	

module.exports = (grunt) ->	
	matchdep.filterDev('grunt-*').forEach (task)-> grunt.loadNpmTasks(task)
	grunt_config.pkg = grunt.file.readJSON 'package.json'
	grunt.initConfig grunt_config

	grunt.registerTask 'start', ['clean', 'jade:debug', 'less', 'copy', 'string-replace', 'coffee', 'watch']
	grunt.registerTask 'package', ['clean', 'jade:release', 'less', 'copy', 'string-replace', 'coffee', 'crx']
	grunt.registerTask 'publish', ['release', 'package']
	


