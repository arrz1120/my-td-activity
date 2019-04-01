let NODE_ENV=process.env.NODE_ENV;
let webpack=require('webpack'),
    autoprefixer=require('autoprefixer'),
    path=require('path'),
    conf=require('./launchConf.js');
  
module.exports={
  entry:{
    //入口文件路径
    advTransition:'./src/lib/advTransition.js'
  },
  output:{
    //输出文件路径
    path:path.resolve(__dirname,'src/js'),
    publicPath:NODE_ENV==='production'?'./js/':'/js/',
    filename:'[name].bundle.js'
  },
  module:{
    rules:[
      {
        test:/\.js$/,
        use:'babel-loader'
      }
    ]
  },
   devServer:{
    port:conf.webpack.port,
    noInfo: true,
    publicPath:'/js/',
    contentBase:path.resolve(__dirname,'src')
  }
}
if(NODE_ENV==='production'){
  module.exports.watch=false;
  module.exports.plugins=(module.exports.plugins||[]).concat([
    new webpack.optimize.UglifyJsPlugin({
      sourceMap: true,
      compress: {
        warnings: false
      }
    })
  ])
}