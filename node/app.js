const express =require('express');
const body_parser=require('body-parser');
const userRouter=require('./routes/userRoutes');
const todoRouter=require('./routes/todoRoutes');


const app=express();
app.use(express.json());


app.use('/',userRouter);
app.use('/',todoRouter);




module.exports=app;