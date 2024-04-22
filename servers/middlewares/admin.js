const jwt = require('jsonwebtoken');
const User = require('../models/user')
const admin = async(req,res,next)=>{
    try{
        const token = req.header('token');
        if(!token){
            //? 401 ==> unauthorized
            return res.status(401).json({msg : 'No auth Token! access denied'});
        }
        const valid = jwt.verify(token,"passwordKey");
    if(!valid){
        return res.status(401).json({msg : 'Token verification faild, unauthorized token'});
    }
    const user = await User.findById(valid.id);
    if(user.type == 'user'){
        return res.status(401).json({msg:'You are not an admin'});
    }
    req.user = valid.id;
    req.token = token;
    next();
    }catch(err){
        res.status(500).json({error : err.message});
    }
}

//? to access authrouter from other file
module.exports = admin;