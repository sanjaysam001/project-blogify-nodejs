**Steps to create a MongoDB Atlas account and connect it to your Node.js application:**

Create MongoDB Atlas Account:

     - Go to https://www.mongodb.com/cloud/atlas
     - Sign up for a free account


Create a Cluster:

     - Click "Build a Cluster"
     - Choose "Shared" (free tier)
     - Select cloud provider and region
     - Click "Create Cluster"


Set Up Database Access:

     - In the left sidebar, click "Database Access"
     - Add a new database user with a secure password


Configure Network Access:

     - In the left sidebar, click "Network Access"
     - Add your current IP address or allow access from anywhere (0.0.0.0/0)


Get Connection String:

     - Click "Connect" on your cluster
     - Choose "Connect your application"
     - Copy the connection string
     - use it in your your .env file 

Install MongoDB Driver in Node.js:
     - npm install mongodb

Connect to MongoDB in your Node.js app:

------
const { MongoClient } = require('mongodb');

const uri = "your_mongodb_connection_string";   #replace the connection string
const client = new MongoClient(uri);

async function connectToMongoDB() {
  try {
    await client.connect();
    console.log("Connected to MongoDB Atlas");
    // Perform database operations here
  } catch (error) {
    console.error("Error connecting to MongoDB:", error);
  }
}

connectToMongoDB();

------


