const express = require('express');
const adminRoute = express.Router();
const admin = require('../middlewares/admin');
const {Product} = require('../models/product');
const Order = require('../models/order');

//? add product function
adminRoute.post("/admin/addproduct",admin,async(req,res)=>{
    try{
        const{name, description,images,quantity,price,category} = req.body;
        let product =new Product({
            name:name,
            description :description,
            images : images,
            quantity : quantity,
            price:price,
            category:category,
        });

        product = await product.save();
        res.json(product);
    }catch(e){
        res.status(500).json({error:e.message});
    }
});

//? get All Products for home Screen

adminRoute.get("/admin/getproducts",admin,async(req,res)=>{
    try{
        const products= await Product.find();
        res.json(products);
    }catch(e){
        res.status(500).json({error:e.message});
    }
    
});

//? delete product from db
adminRoute.post("/admin/deleteproduct",admin,async(req,res)=>{
    try{
        const {id} =req.body;
        let product = await Product.findByIdAndDelete(id);
        
        res.json("product deleted successfuly.");
    }catch(e){
        res.status(500).json({error:e.message});
    }
});

//? get All Users Orders 
adminRoute.get("/admin/getallorders",admin,async(req,res)=>{
    try{
        const orders = await Order.find({});
        res.json(orders);
    }catch(e){
        res.status(500).json({error:e.message});
    }
});
//? change order status
adminRoute.post("/admin/changeorderstatus",admin,async(req,res)=>{
    try{
        const {orderId ,currentStatus} = req.body;
        let order = await Order.findById(orderId);
        order.status = currentStatus;
        order = await order.save();
        res.json(order);
    }catch(e){
        res.status(500).json({error:e.message});
    }
});

adminRoute.get('/admin/analytics',admin,async(req,res)=>{
    try{
        let orders = await Order.find({});
        let totalEarning = 0;
        for(let i =0;i<orders.length;i++){
            for(let j=0;j<orders[i].products.length;j++){
                
                totalEarning += orders[i].products[j].quantity * orders[i].products[j].product.price;
            }
        }
        //? Category Wise order fetching
       let mobileEarning = await fetchCategoryWiseProduct('Mobiles');
       let essentialsEarning = await fetchCategoryWiseProduct('Essentials');
       let appliancesEarning = await fetchCategoryWiseProduct('Appliances');
       let booksEarning = await fetchCategoryWiseProduct('Books');
       let fashionEarning = await fetchCategoryWiseProduct('Fashion');
       let earings = {
        totalEarning,
        mobileEarning,
        essentialsEarning,
        appliancesEarning,
        booksEarning,
        fashionEarning,
       }
       res.json(earings);
    }catch(e){
        res.status(500).json({error:e.message});
    }
});

async function fetchCategoryWiseProduct(category){
    let earning=0;
    let categoryOrders = await Order.find({
        'products.product.category':category,
    });

    for(let i =0;i<categoryOrders.length;i++){
            for(let j=0;j<categoryOrders[i].products.length;j++){
                earning += categoryOrders[i].products[j].quantity * categoryOrders[i].products[j].product.price;
            }
        }
    return earning;
}


module.exports = adminRoute;