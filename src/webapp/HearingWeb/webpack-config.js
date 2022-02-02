const HtmlWebPackPlugin = require( 'html-webpack-plugin' );

module.exports = {
    devtool: 'source-map',
    entry: "./app.tsx",
    mode: "development",
    output: {
        filename: "./app-bundle.js"
    },
    resolve: {
        extensions: ['.Webpack.js', '.web.js', '.ts', '.js', '.jsx', '.tsx'],
        modules: ['node_modules']
    },
    module: {
        rules: [
            {
                test: /\.tsx$/,
                exclude: /(node_modules|bower_components)/,
                use: {
                    loader: 'ts-loader'
                }
            },
            {
                    test: /\.css$/,
                    use: ["style-loader", "css-loader"]
            }
        ]
    },
    devServer: {
        static: "./dist"
    },

}