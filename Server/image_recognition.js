// <environment>
'use strict';
require("dotenv").config();
const { syncBuiltinESMExports } = require('module');

const axios = require('axios').default;

let subscriptionKey = process.env.SUBSCRIPTION_KEY
let endpoint = 'https://cpen391.cognitiveservices.azure.com'

let verifiedFaceIds = ['356dd42a-5f5e-4a75-bf14-f37588dee01f']

// Calls Microsoft Face API to retrive Face ID
let getFaceId = async (imageUrl) => {
    return axios({
        method: 'post',
        url: endpoint + '/face/v1.0/detect',
        params: {
            detectionModel: 'detection_03',
            returnFaceId: true
        },
        data: {
            url: imageUrl,
        },
        headers: { 'Ocp-Apim-Subscription-Key': subscriptionKey }
    })
        .then(function (response) {
            console.log(response.data);
            return response.data[0].faceId
        }).catch(function (error) {
            console.log(error)
        });
}
// Calls Microsoft Face API to get confidence score between two Face IDs
let getConfidenceScore = (id1, id2) => {
    return axios({
        method: 'post',
        url: endpoint + '/face/v1.0/verify',
        data: {
            faceId1: id1,
            faceId2: id2
        },
        headers: { 'Ocp-Apim-Subscription-Key': subscriptionKey }
    })
};

// Checks to see if an image URL matches one of our verified face ids
let checkVerify = async (imageUrl) => {
    let faceId = await getFaceId(imageUrl);
    let score = await getConfidenceScore(faceId, verifiedFaceIds[0]);
    return score;
}

module.exports = {
    checkVerify: checkVerify
}

