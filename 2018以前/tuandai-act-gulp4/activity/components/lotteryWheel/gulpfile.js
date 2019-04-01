let browserSync=require('browser-sync'),
    gulp=require('gulp'),
    less=require('gulp-less'),
    cssnano=require('gulp-cssnano'),
    autoprefixer=require('gulp-autoprefixer'),
    plumber=require('gulp-plumber'),
    runSequence=require('run-sequence');

gulp.task('browserSync',()=>{
  browserSync.init({
    // server:{
    //   baseDir:'./src',
    //   index:'index.html'
    // },
    proxy: "localhost:8888",
  })
})

gulp.task('less',()=>{
  return gulp.src('src/css/*.less')
    .pipe(plumber())
    .pipe(less())
    .pipe(cssnano())
    .pipe(autoprefixer())
    .pipe(gulp.dest('src/css'))
    .pipe(browserSync.reload({stream:true}))
})

gulp.task('watch',()=>{
  gulp.watch('src/css/*.less',['less'])
  gulp.watch('src/*.html',browserSync.reload)
})

gulp.task('dev',callback=>{
  runSequence('less','browserSync','watch',callback)
})

gulp.task('build:html',()=>{
  return gulp.src('src/*.html')
    .pipe(gulp.dest('build/'))
})

gulp.task('build:img',()=>{
  return gulp.src('src/images/**/*')
    .pipe(gulp.dest('build/images/'))
})

gulp.task('build:css',()=>{
  return gulp.src('src/css/**/*')
    .pipe(gulp.dest('build/css/'))
})
gulp.task('build:js',()=>{
  return gulp.src('src/js/**/*')
    .pipe(gulp.dest('build/js/'))
})

gulp.task('build',['build:html','build:js','build:img','build:css'])