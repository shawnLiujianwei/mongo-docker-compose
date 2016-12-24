// Require mongodb
var MongoClient = require('mongodb').MongoClient;
var url = 'mongodb://localhost:28018,localhost:28019,localhost:30000/example_db?replicaSet=my-mongo-set';
var url1 = "mongodb://localhost:1000/example_db";
var url2 = "mongodb://localhost:2000/example_db";
// Connect
MongoClient.connect(url, function(err, db) {
if(err) {
    console.error(err);
    process.exit()
}
    // Create a collection we want to drop later
    var collection = db.collection('simple_limit_skip_query_with_promise');
    // Insert a bunch of documents for the testing
    //collection.insertMany([{a:11, b:11}, {a:21, b:21}, {a:31, b:3}], {w:1}).then(function(result) {

        // Peform a simple find and return all the documents
        collection.find({}).toArray().then(function(docs) {
                console.log(docs)
                db.close();
            });
    //});
});

//rs.initiate({_id:"my-mongo-set",members:[{_id:0,host:"mongo1:27017"},{_id:1,host:"mongo2:27017"},{_id:2,host:"mongo3:27017"}]})