var concat = require('gulp-concat');  
var rename = require('gulp-rename');  
var uglify = require('gulp-uglify'); 
var gulp = require('gulp'); 

//script paths
var jsFiles = 'js/**/*.js',  
    jsDest = 'dist/js';

gulp.task('scripts', function() {  
    return gulp.src(jsFiles)
        .pipe(concat('index.js'))
        .pipe(gulp.dest(jsDest));
});

gulp.task('watch', function() {
   gulp.watch('**/*.js', ['scripts'])
});