var gulp = require('gulp');
var stylus = require('gulp-stylus');

gulp.task('stylus', function () {
  gulp.src('dev/style.styl')
    .pipe(stylus({}))
    .pipe(gulp.dest('www/css'));
});

gulp.task('default', ['stylus'], function() {

});