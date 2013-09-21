matchdep = require 'matchdep'


grunt_config = 
	
	jade: 
		watch: files: "./app.nw/index.html" : "./src/views/index.jade"

	coffee:
		watch: 
			expand: true
			flatten: true
			src: ['./src/coffee/*.coffee']
			dest: './app.nw/js/'
			ext: '.js'

	
	less: 
		watch: files: "./app.nw/css/styles.css" : "./src/less/styles.less"
	
	clean: pack: ['./bin/node-webkit.app/Contents/Resources']

	copy: 
		css: files : [expand: true, cwd:'./src', src: ['css/**'], dest: './app.nw/']
		img: files : [expand: true, cwd:'./src', src: ['img/**'], dest: './app.nw/']
		js: files :  [expand: true, cwd:'./src', src: ['js/**'], dest: './app.nw/']
		pack: files:
			[
				src:['./src/manifest.json'], dest: './app.nw/package.json'
			,
				cwd:'./node_modules/', src:['jade/**', 'restler/**', 'moment/**', 'underscore/**'], dest: './app.nw/node_modules', expand: true
			]
		app: files:
			[
				src: ['./app.nw/**']
				dest: './bin/node-webkit.app/Contents/Resources/'
				expand: true
			]
			
			
		
	
	watch:
		binupdate: files: ["./app.nw/**"], options: livereload: true, event: 'all'
		jade:files: "./src/views/**", tasks: ["jade"]
		less:files: "./src/less/**", tasks: ["less"]
		css:files: "./src/css/**", tasks: ["copy:css"]
		js:files: "./src/js/**", tasks: ["copy:js"]
		img:files: "./src/img/**", tasks: ["copy:img"]		
		coffee:files: "./src/coffee/**", tasks: ["coffee"]

	

module.exports = (grunt) ->	
	matchdep.filterDev('grunt-*').forEach (task)-> grunt.loadNpmTasks(task)

	grunt.initConfig grunt_config
	grunt.registerTask 'pack', ['build','clean:pack', 'copy:pack', 'copy:app']
	grunt.registerTask 'build', ['jade', 'less', 'copy:css', 'copy:js', 'copy:img', 'coffee']
	grunt.registerTask 'start', ['build', 'watch']
