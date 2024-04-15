const mongooes = require('mongoose');

const userSchema = mongooes.Schema({
    name :{
        require : true,
        trim : true,
        type : String,
    },
    email :{
        require : true,
        trim : true,
        type : String,
        validate:{
            validator:(value)=>{
                //? regX for email Validator 
                const re =/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            massage: "please enter a valid email address",
        }
    },
    password :{
        require : true,
        type : String,
    },
    address : {
        default : '',
        type : String,
    },
    type :{
        type : String,
        default: 'user',
    },
});

const User = mongooes.model('User', userSchema);
module.exports = User;