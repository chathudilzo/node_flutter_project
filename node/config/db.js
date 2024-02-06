const mongoose=require('mongoose');
require('dotenv').config();


const url=process.env.DBURL;


const connectionParams={
    useNewUrlParser: true,
    useUnifiedTopology: true 
}


const dbConnection=mongoose.connect(url,connectionParams).then(()=>{
    console.log('Connected to db')
}).catch((err)=>{
    console.error(`Error connecting to database ${err}`);
})


module.exports=dbConnection;
