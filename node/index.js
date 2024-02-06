const app=require ('./app');
const db=require('./config/db');
const userModel=require('./model/userModel');

const port =3000;

app.get('/',(req,res)=>{
    res.send('Hello World!!');
})


app.listen(port,()=>{
    console.log(`Server running on port http://localhost:${port}`);
})