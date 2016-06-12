'use strict';

var path = require('path');
var gulp = require('gulp');
var conf = require('./conf');

var browserSync = require('browser-sync');

var $ = require('gulp-load-plugins')();

gulp.task('markups', function() {
  function renameToHtml(path) {
    path.extname = '.html';
  }

  return gulp.src(path.join(conf.paths.src, '/app/**/*.jade'))
    .pipe($.consolidate('jade', { basedir: conf.paths.src, doctype: 'html', pretty: '  ', dev: true})).on('error', conf.errorHandler('Jade'))
    .pipe($.rename(renameToHtml))
    .pipe(gulp.dest(path.join(conf.paths.tmp, '/serve/app/')))
    .pipe(browserSync.reload({ stream: true }));
});

gulp.task('markups:dist', function() {
  function renameToHtml(path) {
    path.extname = '.html';
  }

  return gulp.src(path.join(conf.paths.src, '/app/**/*.jade'))
    .pipe($.consolidate('jade', { basedir: conf.paths.src, doctype: 'html', pretty: '  ', dev: false})).on('error', conf.errorHandler('Jade'))
    .pipe($.rename(renameToHtml))
    .pipe(gulp.dest(path.join(conf.paths.tmp, '/serve/app/')))
    .pipe(browserSync.reload({ stream: true }));
});
