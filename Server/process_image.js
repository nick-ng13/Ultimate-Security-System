const express = require('express'), fs = require('fs'), url = require('url');;
const app = express();
const port = 8080;
const { exec } = require("child_process");
const {imageUpload} = require("./upload_png");
const {checkVerify} = require("./image_recognition");
const {sendEmail} = require("./email");

app.use(express.json());
let count = 1; 
let verified = false;
let timeout;
let filePath = 'data.txt'

// Get request to retrieve response
app.get('/', function (request, respond) {
    if(verified){
        respond.sendStatus(210);
        verified = false;
    }else{
        respond.sendStatus(220);
    }
});

// Post request that starts a timer for 10 seconds, if no POST request has been
// received in 10 seconds it will start verifying the photo
app.post('/', function (request, respond) {
    clearTimeout(timeout)
    timeout = setTimeout(verify,10000);
    console.log(count)
    count++;    
    fs.appendFile(filePath,request.body.body, function(err){
        if(err) throw err;
        console.log("Written!")
    })    
    respond.sendStatus(200)
});


// Runs python script to generate a png based on RGB pixel values. It then uploads
// the file to Amazon S3 to get a URL that is then passed onto Microsoft Face API.
// An email is then sent containing the results as well as an image that has been processed
function verify(){
    filePath = 'data.txt'
    console.log("RGB Data done sending, executing Python script to render image");
    exec("python rgb_to_img.py", async (error, stdout, stderr) => {
        fs.truncate(filePath, 0, function(){console.log('Deleted data.txt')})
        if (error) {
            console.log(`error: ${error.message}`);
            return;
        }
        if (stderr) {
            console.log(`stderr: ${stderr}`);
            return;
        }
        console.log("Finished rendering image, uploading image to S3");
        let URL = await imageUpload('testrgb.png')
        console.log("Uploaded to S3, running face verification")
        checkVerify(URL).then((data) =>{
            verified = data.data.isIdentical;
            console.log(data.data)
            console.log("Sending email now!")
            sendEmail(verified,URL);
        }).catch((error) => {
            verified = false;
            console.log(error);
            sendEmail(false,URL);
        });          
    });

}
app.listen(port, () => {
    console.log(`Server listening on port ${port}`);
})

