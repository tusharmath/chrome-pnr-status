matchdep = require 'matchdep'


grunt_config = 
	opt: 
		debugPath: './bin/debug',
		release: './bin/release/<%= pkg.version %>'

	jade: 
		debug:
			options: data: debug: true
			files: "<%= opt.debugPath%>/window.html" : "./src/views/index.jade"
		release:
			options: data: debug: false
			files: "./bin/window.html" : "./src/views/index.jade"
	
	copy:
		debug: files: [
				expand: true
				cwd: './src/'
				src: ['content/**']
				dest: '<%= opt.debugPath%>/'
			,	
				src: ['./src/manifest.json']
				dest: '<%= opt.debugPath%>/manifest.json'
			]

	'string-replace': debug:
		options: 
			replacements:[
					pattern: "APPLICATION_VERSION"
					replacement: "<%= pkg.version %>"
				,
					pattern: "APPLICATION_NAME"
					replacement: "<%= pkg.name %>"
				]
		files: '<%= opt.debugPath%>/manifest.json': './src/manifest.json'
	
	browserify:
		background:
			options: transform: ['coffeeify']
			files: '<%= opt.debugPath%>/background.js': ['./src/background/main.coffee']
		scripts:
			options: transform: ['coffeeify']
			files: '<%= opt.debugPath%>/script.js': ['./src/scripts/main.coffee']
	
	less: 
		debug: files: "<%= opt.debugPath%>/content/css/styles.css" : "./src/less/styles.less"
	
	clean: pack: ['./bin/node-webkit.app/Contents/Resources']

			
		
	
	watch:
		binupdate: files: ["<%= opt.debugPath%>/**"], options: livereload: true
		jade:files: "./src/views/**", tasks: ["jade:debug"]
		less:files: "./src/less/**", tasks: ["less:debug"]
		content:
			files: ["./src/content/**"],tasks: ["copy:debug"]
		manifest:
			files: ["./src/manifest.json"], tasks: ["string-replace:debug"]
		

		background:files: "./src/background/**", tasks: ["browserify:background"]
		scripts:files: "./src/scripts/**", tasks: ["browserify:scripts"]

	

module.exports = (grunt) ->	
	matchdep.filterDev('grunt-*').forEach (task)-> grunt.loadNpmTasks(task)
	grunt_config.pkg = grunt.file.readJSON 'package.json'
	grunt.initConfig grunt_config
	grunt.registerTask 'pack', ['build','clean:pack', 'copy:pack', 'copy:app']
	grunt.registerTask 'build', [
		'jade:debug', 
		'less:debug',
		'copy:debug',
		'string-replace:debug',
		'browserify'
	]
	grunt.registerTask 'start', ['build', 'watch']
