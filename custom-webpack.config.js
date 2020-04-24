const webpack = require('webpack')
const keys = Object.keys(process.env);

let env = {};
keys.forEach(key => env[key] = JSON.stringify(process.env[key]));

module.exports = {
    plugins: [
        new webpack.DefinePlugin({      
            'ENV_VARS': env    
        })
    ]
}