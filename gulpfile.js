const gulp = require("gulp");
const workbox = require("workbox-build");
const uglifyes = require('uglify-es');
const composer = require('gulp-uglify/composer');
const uglify = composer(uglifyes, console);
const pipeline = require('readable-stream').pipeline;
const minifycss = require('gulp-clean-css');
const htmlmin = require('gulp-htmlmin');
const htmlclean = require('gulp-htmlclean');

// 压缩 public 目录内 css
gulp.task('minify-css', function() {
    return gulp.src('./public/**/*.css')
        .pipe(minifycss({
            advanced: true,//类型：Boolean 默认：true [是否开启高级优化（合并选择器等）]
            compatibility: '*',//保留ie7及以下兼容写法 类型：String 默认：''or'*' [启用兼容模式； 'ie7'：IE7兼容模式，'ie8'：IE8兼容模式，'*'：IE9+兼容模式]
            keepBreaks: true,//类型：Boolean 默认：false [是否保留换行]
            keepSpecialComments: '*'//保留所有特殊前缀 当你用autoprefixer生成的浏览器前缀，如果不加这个参数，有可能将会删除你的部分前缀
        }))
        .pipe(gulp.dest('./public'));
});

// 压缩 public 目录内 html
gulp.task('minify-html', function() {
    return gulp.src('./public/**/*.html')
        .pipe(htmlclean())
        .pipe(htmlmin({
            removeComments: true,//清除 HTML 注释
            collapseWhitespace: true,//压缩 HTML
            preserveLineBreaks: true,//试图修正被错误取掉的换行符问题
            collapseBooleanAttributes: true,//省略布尔属性的值 <input checked="true"/> ==> <input />
            removeEmptyAttributes: true,//删除所有空格作属性值 <input id="" /> ==> <input />
            removeScriptTypeAttributes: true,//删除 <script> 的 type="text/javascript"
            removeStyleLinkTypeAttributes: true,//删除 <style> 和 <link> 的 type="text/css"
            minifyJS: true,//压缩页面 JS
            minifyCSS: true//压缩页面 CSS
        }))
        .pipe(gulp.dest('./public'))
});

// 压缩 public/js 目录内 js
gulp.task('minify-js', function() {
    return gulp.src('./public/**/*.js')
        .pipe(uglify())
        .pipe(gulp.dest('./public'));
});
  
gulp.task('generate-service-worker', () => {
    return workbox.injectManifest({
        swSrc: './sw-template.js',
        swDest: './public/sw.js',
        globDirectory: './public',
        globPatterns: [
            "**/*.{html,css,js,json,woff2}"
        ],
        modifyURLPrefix: {
            "": "./"
        }
    });
});

gulp.task("uglify", function () {
    return pipeline(
        gulp.src("./public/sw.js"),
        uglify(),
        gulp.dest("./public")
    );
});

gulp.task("build", gulp.series("minify-html", "minify-css", "minify-js", "generate-service-worker", "uglify"));