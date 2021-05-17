const express = require('express'); // importa express
const app = express(); // genera la app
const mysql = require('mysql2');

app.use(express.json())


const connection = mysql.createConnection({
    host: 'ProyectoGDSP',
    user: 'root',
    password: '123456',
    database: 'Food_services',
  });

// ---- GET PRODUCT OPTIONS
// ---- receives productName
app.get('/api/v1/productOptions/:productName', (req, res) => {
    const { productName } = req.params;
    
    console.log(`Request from ${req.ip} to  path ${req.url}.`)

    connection.query('CALL getProductOptions(?);',
    [productName],
    (err, data, fields) => {
        if (err) throw err;
        res.status(200).json({
            data,
        })
    })
});



// ---- GET USER ORDERS
// ---- receives userName 
app.get('/api/v1/userOrders/:userName', (req, res) => {
    const { userName } = req.params;
    
    console.log(`Request from ${req.ip} to  path ${req.url}.`)

    connection.query('CALL getOrders(?);',
    [userName],
    (err, data, fields) => {
        if (err) throw err;
        res.status(200).json({
            data,
        })
    })
});


// ---- GET Product Commerce Menu
// ---- receives nothing
app.get('/api/v1/productCommerceMenu', (req, res) => {
    
    console.log(`Request from ${req.ip} to  path ${req.url}.`)

    connection.query('CALL getProductCommerceMenu();',
    (err, data, fields) => {
        if (err) throw err;
        res.status(200).json({
            data,
        })
    })
});

// ---- GET COMMERCE OF MENUS
// ---- receives menuName
app.get('/api/v1/commerceOfMenus/:menuName', (req, res) => {
    const { menuName } = req.params;
    
    console.log(`Request from ${req.ip} to  path ${req.url}.`)

    connection.query('CALL getCommerceOfMenu(?);',
    [menuName],
    (err, data, fields) => {
        if (err) throw err;
        res.status(200).json({
            data,
        })
    })
});

// ---- GET USER PERMISSIONS JSON
// ---- receives userEmail
app.get('/api/v1/userPermissions/:userEmail', (req, res) => {
    const { userEmail } = req.params;
    
    console.log(`Request from ${req.ip} to  path ${req.url}.`)

    connection.query('CALL getUserPermissions(?);',
    [userEmail],
    (err, data, fields) => {
        if (err) throw err;
        res.status(200).json({
            data,
        })
    })
});

const PORT = 8080;
app.listen(
    PORT,
    () => console.log(`Alive in http://localhost:${PORT}`)
)