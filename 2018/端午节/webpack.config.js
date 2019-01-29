const path=require('path')
const webpack=require('webpack')
const HtmlWebpackPlugin=require('html-webpack-plugin')
const CopyWebpackPlugin=require('copy-webpack-plugin')
const ExtractTextPlugin=require("extract-text-webpack-plugin")
const CleanWebpackPlugin=require('clean-webpack-plugin')
const autoprefixer=require('autoprefixer')
const jsonfile=require('jsonfile')
const randomatic=require('randomatic')
const projectConfig=jsonfile.readFileSync('./project.config.json')
const NODE_ENV=process.env.NODE_ENV

let getPages=projectConfig.pages.map((item,i)=>{
  return new HtmlWebpackPlugin({
    title:item.title||'Document',
    template:`./src/views/${item.tmpl}`,
    filename:item.tmpl,
    minify:false,
    inject:false,
    chunks:item.scripts,
    chunksSortMode:'manual'
  })
})

module.exports={
  entry:projectConfig.entry,
  output:{
    path:path.resolve(__dirname,'./build'),
    filename:'js/[name].bdle.js?[hash]',
    publicPath:'',
    hashDigestLength:8
  },
  module:{
    rules:[

      // jquery 全局
      {
        test: require.resolve('jquery'),
        use: [
          {loader: 'expose-loader',options: 'jQuery'},
          {loader: 'expose-loader',options: '$'},
          {loader: 'expose-loader',options: 'Q'}
        ]
      },

      // js
      {
        test:/\.js$/,
        use:'babel-loader',
        exclude:/node_modules/
      },

      // html
      {
        test:/\.html$/,
        use:['handlebars-loader']
      },
      
      // sass
      {
        test:/\.(scss|css)$/,
        exclude:/node_modules/,
        use:['css-hot-loader'].concat(ExtractTextPlugin.extract({
          fallback:'style-loader',
          use:[
            'css-loader',
            {
              loader:'postcss-loader',
              options:{
                ident:'postcss',
                plugins:()=>[
                  autoprefixer({
                    browsers:['last 2 versions','Android >= 4.0','iOS 7']
                  })
                ]
              }
            },
            'sass-loader'
          ]
        }))
      },

      // png|jpg|gif
      {
        test:/\.(png|jpg|gif)$/,
        exclude:path.resolve(__dirname, "src/js/components"),
        use:[
          {
            loader: 'url-loader',
            options: {
              context:'./src',
              publicPath:'../',
              name: `[path][name].[ext]?${randomatic('a0',8)}`,
              limit: 3*1024,
            }
          }
        ]
      },
      {
        test:/\.(png|jpg|gif)$/,
        include:path.resolve(__dirname, "src/js/components"),
        use:[
          {
            loader: 'url-loader',
            options: {
              context:'./src/js',
              publicPath:'../images/',
              outputPath:'images/',
              name: `[path][name].[ext]?${randomatic('a0',8)}`,
              limit: 3*1024,
            }
          }
        ]
      }
    ]
  },
  plugins:[

    // clean build/
    new CleanWebpackPlugin('build/'),

    // webpack 全局变量:__DEV__
    new webpack.DefinePlugin({
      __DEV__:NODE_ENV==='production'?false:true
    }),

    // 提取 css
    new ExtractTextPlugin('css/[name].css?[hash]'),

    // 压缩 js/css
    new webpack.optimize.UglifyJsPlugin({
      compress: {
        warnings: false
      }
    }),
    
    // 复制文件
    new CopyWebpackPlugin([
      {
        from:__dirname+'/src/images',
        to:'images/',
        cache:true
      },
      {
        from:__dirname+'/src/js',
        to:'js/',
        ignore:['lib/**/*','components/**/*'],
        cache:true
      },
      {
        from:__dirname+'/src/css',
        to:'css/',
        cache:true
      }
    ]),
  ]
}
module.exports.plugins=(module.exports.plugins||[]).concat(getPages)