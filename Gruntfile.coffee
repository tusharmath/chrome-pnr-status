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
		options: livereload: true
		jade: files: "./src/views/**", tasks: ["jade"]
		less: files: "./src/less/**", tasks: ["less"]
		css: files: "./src/css/**", tasks: ["copy:css"]
		js: files: "./src/js/**", tasks: ["copy:js"]
		img: files: "./src/img/**", tasks: ["copy:img"]

	

module.exports = (grunt) ->
	tasks.forEach (task)-> grunt.loadNpmTasks("grunt-contrib-#{task}")
	grunt.initConfig grunt_config
	grunt.registerTask 'start', ['jade', 'less', 'copy', 'watch']
