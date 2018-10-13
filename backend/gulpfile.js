'use strict'

const gulp = require('gulp')
const standard = require('gulp-standard')

gulp.task('standard', function () {
  return gulp.src(['./lib/*.js', './functions/*.js', './functions/**/*.js'])
    .pipe(standard())
    .pipe(standard.reporter('default', {
      breakOnError: true
    }))
})
