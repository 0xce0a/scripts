#!/bin/bash


GREEN='\033[0;32m'
NC='\033[0m'

#yarn config
yarn init
yarn add express mongoose body-parser pug


#initialize git repo
git init
touch .gitignore
echo "node_modules" > .gitignore

#make views dir
mkdir views
touch views/layout.pug
touch views/index.pug
echo -e "${GREEN}CREATE${NC}: views"

#make models dir
mkdir models
touch models/index.js
echo "
const mongoose = require('mongoose');
const db = 'mongodb://localhost:27017/testdb';
const promise = mongoose.Promise;
mongoose.connect(db, { useNewUrlParser: true })
.then(()=>{
    console.log('mongodb : connected')
})
.catch((err)=>{
    console.log(err)
});
" > models/index.js
echo -e "${GREEN}CREATE${NC}: models"

#make routes dir
mkdir routes
touch routes/routes.js
echo "
const express = require('express');
const router = express.Router();
const bodyParser = require('body-parser');
router.use(bodyParser.urlencoded({extended: true}));

router.get('/', (req,res)=>{
    res.send('hello world!!');
})

module.exports = router;
" > routes/routes.js
echo -e "${GREEN}CREATE${NC}: routes"

#make public dir
mkdir public
echo -e "${GREEN}CREATE${NC}: public"
touch app.js
echo "
const express = require('express');
const app = express();
const router = require('./routes/routes')
const PORT = process.env.PORT || 8080;
const ip = process.env.IP;

app.set('view engine', 'pug');
app.use('/', router);
app.use(express.static('public'));
app.listen(PORT,IP,()=>{
    console.log('server running on port ' + PORT);
});
" > app.js
echo -e "${GREEN}CREATE${NC}: app"

#create licence
touch LICENSE
echo "
Copyright 2018 Sachin Saini

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE." > LICENSE
echo -e "${GREEN}CREATE${NC}: license"
