let browserSync=require('browser-sync'),
    gulp=require('gulp'),
    less=require('gulp-less'),
    cssnano=require('gulp-cssnano'),
    autoprefixer=require('gulp-autoprefixer'),
    plumber=require('gulp-plumber'),
    imagemin=require('gulp-image');
    cssVersioner=require('gulp-css-url-versioner'),
    runSequence=require('run-sequence'),
    launchConf=require('./launchConf.js');

gulp.task('browserSync',()=>{
  let conf;
  if(launchConf.webpack.use){
    conf={
      proxy: `localhost:${launchConf.webpack.port}`,
    }
  }else{
    conf={
      server:{
        baseDir:'./src',
        index:'index.html'
      }
    }
  }
  browserSync.init(conf)
})

gulp.task('less',()=>{
  return gulp.src('src/css/*.less')
    .pipe(plumber())
    .pipe(less())
    .pipe(cssnano())
    .pipe(autoprefixer({
      browsers:['last 2 versions','Android >= 4.0','iOS 7']
    }))
    .pipe(gulp.dest('src/css'))
    .pipe(browserSync.reload({stream:true}))
})

gulp.task('watch',()=>{
  gulp.watch('src/css/*.less',['less']);
  gulp.watch('src/*.html',browserSync.reload);  
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
    .pipe(imagemin({

      pngquant: true,
      optipng: true,
      
      mozjpeg: false,
      guetzli: true,
      
      concurrent: 10
    }))
    .pipe(gulp.dest('build/images/'))
})

gulp.task('build:css',()=>{
  return gulp.src('src/css/**/*.css')
    .pipe(cssVersioner({
      variable: 'v',
      version: Date.now(),
      lastcommit: true
    }))
    .pipe(gulp.dest('build/css/'))
})

gulp.task('build:js',()=>{
  return gulp.src('src/js/**/*')
    .pipe(gulp.dest('build/js/'))
})

gulp.task('build',['build:html','build:js','build:img','build:css'])