matchdep = require 'matchdep'
output = "./build"

grunt_config = 
	
	jade: 
		watch: files: "./bin/index.html" : "./src/views/index.jade"

	coffee:
		watch: 
			expand: true
			flatten: true
			src: ['./src/coffee/*.coffee']
			dest: './bin/js/'
			ext: '.js'

	
	less: 
		watch: files: "./bin/css/styles.css" : "./src/less/styles.less"
	
	copy: 
		css: files : [expand: true, cwd:'./src', src: ['css/**'], dest: './bin/']
		img: files : [expand: true, cwd:'./src', src: ['img/**'], dest: './bin/']
		js: files :  [expand: true, cwd:'./src', src: ['js/**'], dest: './bin/']
	
	
	watch:  
		options: livereload: true, event: 'all'
		jade:files: "./src/views/**", tasks: ["jade"]
		less:files: "./src/less/**", tasks: ["less"]
		css:files: "./src/css/**", tasks: ["copy:css"]
		js:files: "./src/js/**", tasks: ["copy:js"]
		img:files: "./src/img/**", tasks: ["copy:img"]		
		coffee:files: "./src/coffee/**", tasks: ["coffee"]

	

module.exports = (grunt) ->	
	matchdep.filter('grunt-*').forEach (task)-> grunt.loadNpmTasks(task)

	grunt.initConfig grunt_config
	grunt.registerTask 'build', ['jade', 'less', 'copy', 'coffee']
	grunt.registerTask 'start', ['build', 'watch']
