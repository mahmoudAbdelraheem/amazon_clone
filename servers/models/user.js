const mongooes = require('mongoose');
const { productSchema } = require('./product');


const userSchema = mongooes.Schema({
    name :{
        required : true,
        trim : true,
        type : String,
    },
    email :{
        required : true,
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
        required : true,
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
    cart :[
        {
            product : productSchema,
        
        quantity : {
            type: Number,
            required : true,
        },
    },
    ],
});

const User = mongooes.model('User', userSchema);
module.exports = User;