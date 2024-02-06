const express =require('express');
const body_parser=require('body-parser');
const userRouter=require('./routes/userRoutes');

const app=express();
app.use(express.json());


app.use('/',userRouter);




module.exports=app;