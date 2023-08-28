const sgMail = require('@sendgrid/mail')
require("dotenv").config();
sgMail.setApiKey(process.env.SENDGRID_API_KEY)

// Function to send email, body of the email is depending on the boolean value
function sendEmail(boolean,URL){
    let body;
    if(boolean){
        body = "A verified individual is attempting to unlock."
    }else{
        body = "An unindentified individual has attempted to unlock the safe, was this you?"
    }
    const msg = {
        to: [process.env.SENDGRID_EMAIL_TO_1,process.env.SENDGRID_EMAIL_TO_2],
        from: process.env.SENDGRID_EMAIL_FROM, 
        subject: 'CPEN 391 L2B-19 Security System',
        html: body + '<br><br><img src="' + URL + '">' ,
      }
      sgMail
        .send(msg)
        .then(() => {
          console.log('Email sent')
        })
        .catch((error) => {
          console.error(error)
        })
}


module.exports = {
    sendEmail: sendEmail
  }
