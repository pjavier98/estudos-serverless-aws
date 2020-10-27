'use strict';

const settings = require('./config/settings');
const axios = require('axios');
const cheerio = require('cheerio');
const AWS = require('aws-sdk');
const uuid = require('uuid');

class Handler {
  constructor(dynamoDB) {
    this.dynamoDB = dynamoDB;
  }

  static async main(event) {
    console.log('at', new Date().toISOString(), JSON.stringify(event, null, 2));

    const { data } = await axios.get(settings.commitMessageUrl);
    const $ = cheerio.load(data);
    const [commitMessage] = await $("#content").text().trim().split('\n');

    console.log('Message: ', commitMessage);

    const params = {
      TableName: settings.dbTableName,
      Item: {
        commitMessage,
        id: uuid.v1(),
        createdAt: new Date().toISOString(),
      }
    }

    await dynamoDB.put(params).promise();

    console.log('Process finished at', new Date().toISOString());

    return {
      statusCode: 200,
    }
  }
}

const dynamoDB = new AWS.DynamoDB.DocumentClient();

module.exports = {
  scheduler: Handler.main.bind(dynamoDB)
}