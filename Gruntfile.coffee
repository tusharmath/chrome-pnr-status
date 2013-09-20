tasks = ['watch', 'coffee', 'jade', 'less' , 'copy']
output = "./build"

grunt_config = 
	
	jade: 
		watch: files: "./bin/index.html" : "./src/views/index.jade"
	
	less: 
		watch: files: "./bin/css/styles.css" : "./src/less/styles.less"
	
	copy: 
		css: files : [expand: true, cwd:'./src', src: ['css/**'], dest: './bin/']
		img: files : [expand: true, cwd:'./src', src: ['img/**'], dest: './bin/']
		js: files :  [expand: true, cwd:'./src', src: ['js/**'], dest: './bin/']
	
	
	watch: 
		jade: files: "./src/views/**", tasks: ["jade"], options: livereload: true
		less: files: "./src/less/**", tasks: ["less"], options: livereload: true
		css: files: "./src/css/**", tasks: ["copy:css"], options: livereload: true
		js: files: "./src/js/**", tasks: ["copy:js"], options: livereload: true
		img: files: "./src/img/**", tasks: ["copy:img"], options: livereload: true

	

module.exports = (grunt) ->
	tasks.forEach (task)-> grunt.loadNpmTasks("grunt-contrib-#{task}")
	grunt.initConfig grunt_config
	grunt.registerTask 'start', ['jade', 'less', 'copy', 'watch']
