require('dotenv').config();

/**
 * This gist was inspired from https://gist.github.com/homam/8646090 which I wanted to work when uploading an image from
 * a base64 string.
 * Updated to use Promise (bluebird)
 * Web: https://mayneweb.com
 *
 * @param  {string}  base64 Data
 * @return {string}  Image url
 */

 const imageUpload = async (fileName) => {
  
    // You can either "yarn add aws-sdk" or "npm i aws-sdk"
    const AWS = require('aws-sdk');
    const fs = require('fs');
    // Configure AWS with your access and secret key.
    const { ACCESS_KEY_ID, SECRET_ACCESS_KEY, AWS_REGION, S3_BUCKET } = process.env;
    // Configure AWS to use promise
    AWS.config.setPromisesDependency(require('bluebird'));
    AWS.config.update({ accessKeyId: ACCESS_KEY_ID, secretAccessKey: SECRET_ACCESS_KEY, region: AWS_REGION });
  
    // Create an s3 instance
    const s3 = new AWS.S3();
  
  
    // Generally we'd have an userId associated with the image
    // For this example, we'll simulate one
    const userId = 1;
  
    // With this setup, each time your user uploads an image, will be overwritten.
    // To prevent this, use a different Key each time.
    // This won't be needed if they're uploading their avatar, hence the filename, userAvatar.js.
    const fileContent = fs.readFileSync(fileName);

    const randomNumber = Math.floor(Math.random() * 100);
    const params = {
      Bucket: S3_BUCKET,
      Key: randomNumber.toString() + '.png', // File name you want to save as in S3
      Body: fileContent,
      ACL: 'public-read',
      ContentType: `image/png`
  };
    
    // The upload() is used instead of putObject() as we'd need the location url and assign that to our user profile/database
    // see: http://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/S3.html#upload-property
    let location = '';
    let key = '';
    try {
      const { Location, Key } = await s3.upload(params).promise();
      location = Location;
      key = Key;
    } catch (error) {
       // console.log(error)
    }
    
    // Save the Location (url) to your database and Key if needs be.
    // As good developers, we should return the url and let other function do the saving to database etc
     console.log(location, key);
    
    return location;
    
    // To delete, see: https://gist.github.com/SylarRuby/b3b1430ca633bc5ffec29bbcdac2bd52
  }

  module.exports = {
    imageUpload: imageUpload
  }