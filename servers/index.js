
//? import express package and other packages
const express = require('express');
const mongooes = require('mongoose');


//? inatialize app and port
const PORT = 3000;
const mongoDbUrl = 'mongodb+srv://mahmoudraheemm:Mmoud2031@cluster0.2ewrq3q.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0';
const app = express();

//? import from other files
const authRouter = require('./routes/auth.js');
const adminRoute = require('./routes/admin.js');
//? middlware
app.use(express.json());
app.use(authRouter);
app.use(adminRoute);

//? connect to database useing mongooes 
mongooes
.connect(mongoDbUrl).then(()=>{
    console.log('conected successfuly to db');
}).catch((e)=>{
    console.log(e);
});


//? no IP or 127.0.0.1 => local host 
app.listen(PORT, "0.0.0.0", () => {
    console.log(`contected to the port num = ${PORT} welcom to nodemon`);
});








// console.log('hello');
// //? create a port to listen
// const PORT = 3000;
// //? import express package
// const express = require('express');
// const { get } = require('http');
// //? inatialize app
// const app = express();

// //? create our own api
// app.get('/',(req,res)=>{
//     res.json({
//         'name':'mahmoud',
//         'msg' : 'welcom to my fist node js API project'
// });
// });

// //? listen to the API
// //? GET , PUT, POST , UPDATE , DELETE 
// app.get('/hello-world',( req ,  res)=>{
//     //res.send('hello form get method');
//     res.json({hi:'hello form get method'});
// });
// //? no IP or 127.0.0.1 => local host 
// app.listen(PORT, "0.0.0.0", () => {
//     console.log(`contected to the port num = ${PORT} welcom to nodemon`);
// });