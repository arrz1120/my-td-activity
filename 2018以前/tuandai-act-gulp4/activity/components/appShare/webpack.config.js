let NODE_ENV=process.env.NODE_ENV;
let webpack=require('webpack'),
    autoprefixer=require('autoprefixer'),
    path=require('path');
  
module.exports={
  entry:{
    //入口文件路径
    appShare:'./src/lib/appShare.js'
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
      },
      {
        test:/\.less$/,
        use:[
          'style-loader',
          {
            loader:'css-loader',
            options:{
              // minimize:NODE_ENV==='production'?true:false,
              // modules:true,
              // localIdentName:NODE_ENV==='production'?'[hash:base64:5]':'[name]-[local]',
              camelCase:true
            }
          },
          'resolve-url-loader',
          {
            loader:'postcss-loader',
            options:{
              plugins(){
                return [autoprefixer]
              }
            }
          },
          'less-loader'
        ]
      },
      {
        test: /\.(png|jpg|gif|svg)$/,
        loader: 'file-loader',
        options: {
          name: 'assets/[name].[ext]?[hash]'
        }
      }
    ]
  },
  devServer:{
    port:8888,
    noInfo: true,
    publicPath:'/js/',
    contentBase:path.resolve(__dirname,'src')
  },
  resolve: {
    // react > preact
    "alias": {
      "react": "preact-compat",
      "react-dom": "preact-compat"
    }
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