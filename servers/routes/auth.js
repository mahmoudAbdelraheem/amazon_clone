
const express = require('express');
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');

const User = require('../models/user');
const auth = require('../middlewares/auth');


const authRouter = express.Router();


//? signup route
authRouter.post('/api/signup' ,async (req,res)=>{
    try{
         //! get data from client side
    console.log(`request body =  ${req.body.name}`);
    const {name , email , password} = req.body;
    //? user user models
    const existingUser = await User.findOne({email});
    if(existingUser){
        //? 400 client error
        return res.status(400).json({msg : "this email is exist try another one!"});
    }else {
         const hashPassword= await bcryptjs.hash(password , 8);
        let user = new User({
        email :email,
        password : hashPassword,
        name : name ,
    });
     //! put data in database
        user =await user.save();
        res.json(user);
   
    //! return result for this steps to user { success/faild}
    }
    

    }catch(e){
        //? 500 => for server error respose
        res.status(500).json({error : e.message});
    }
   
});

//? signin route
authRouter.post('/api/signin' ,async (req,res)=>{
    try{
         //! get data from client side
    console.log(`request body  from sign in =  ${req.body}`);
    const {email , password} = req.body;
    //? user user models
    const existingUser = await User.findOne({email});
    if(!existingUser){
        return res.status(400).json({msg : "this user email not exist"});
    }

     const isMatch = await bcryptjs.compare(password,existingUser.password);
     if(!isMatch){
        return res.status(400).json({msg : "this user password not correct"});
     }

        const token = jwt.sign({id:existingUser._id} , "passwordKey");
        res.json({token , ...existingUser._doc});
     
    
    }catch(e){
        //? 500 => for server error respose
        res.status(500).json({error : e.message});
    }
   
});

//? signin route
authRouter.post('/api/tokenIsValid' ,async (req,res)=>{
    try{
    
    const token  = req.header('token'); 
    if(!token){
        return res.json(false);
    }
    const valid = jwt.verify(token,"passwordKey");
    if(!valid){
        return res.json(false);
    }
    const user = await User.findById(valid.id);
    if(!user){
        return res.json(false);
    }
        res.json(true);
    }catch(e){
        //? 500 => for server error respose
        res.status(500).json({error : e.message});
    }
   
});


//? middleware to get user data
authRouter.get('/',auth,async(req,res)=>{
    const user = await User.findById(req.user);
    res.json({...user._doc , token : req.token});
});

//? to access authrouter from other file
module.exports = authRouter;