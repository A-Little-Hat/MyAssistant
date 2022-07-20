const express = require('express');
const cors = require('cors')
const { initializeApp } = require('firebase/app');
const { getAuth, createUserWithEmailAndPassword, signInWithEmailAndPassword } = require("firebase/auth");
const upload = require('express-fileupload');
const { getStorage, ref: sref, uploadBytesResumable, getDownloadURL, listAll } = require('firebase/storage');

const port = process.env.PORT || 5000;
const app = express();
app.listen(port, () => {
    console.log('http://localhost:'+port);
})
app.use(cors())


const firebaseConfig = {
    apiKey: "apiKey",
    authDomain: "authDomain",
    databaseURL: "databaseURL",
    projectId: "projectId",
    storageBucket: "storageBucket",
    messagingSenderId: "messagingSenderId",
    appId: "appId"
  };


const firebaseApp = initializeApp(firebaseConfig);

app.get('/', (req, res) => {
    res.send('Hello World');
})
app.post('/signup', (req, res) => {
    const email = req.query.email;
    const password = req.query.password;
    const username = req.query.name;
    const auth = getAuth();
    createUserWithEmailAndPassword(auth, email, password) //sends auth=true if success otherwise false and error
        .then(user => {
            console.log(user.user.uid);
            set(ref(db, 'users/' + user.user.uid + '/details/'), {username});
            res.status(201).json({
                auth: true,
                code: user.user.uid,
                name: username
            });
        }).catch((err) => {
            res.status(205).json({
                auth: false,
                code: err.code,
                name: ''
            });
        })
})
app.post('/login', (req, res) => {
    let email = req.query.email;
    let password = req.query.password;
    const auth = getAuth();
    signInWithEmailAndPassword(auth, email, password)
        .then((user) => {
            console.log(user.user.uid);
            get(ref(db,'users/' + user.user.uid + '/details/')).then((snapshot) => {
                if (snapshot.exists()) {
                    console.log(snapshot.val());
                    res.status(202).json({
                        auth: true,
                        code: user.user.uid,
                        name: snapshot.val().username
                    });
                } else {
                    res.status(202).json({
                        auth: true,
                        code: user.user.uid,
                        name: 'John Doe'
                    });
                }
            }).catch((error) => {
                console.error(error);
            });
            
        }).catch((err) => {
            res.status(401).json({
                auth: false,
                code: err.code
            });
        })
})


const storage = getStorage(firebaseApp);
app.use(upload());
app.post('/file', (req, res) => {
    const file = req.files.file_field;
    const userId = req.query.userId;
    const fileName = file.name;
    const fileType = file.mimetype;
    const fileSize = file.size;
    const metadata = { fileType, fileSize, fileName };
    const storageRef = sref(storage, 'users/' + userId + '/files/' + fileName);
    const uploadTask = uploadBytesResumable(storageRef, file.data, metadata);
    uploadTask.on('state_changed', async(snapshot) => {
        console.log(snapshot.bytesTransferred);
    });
    res.send('File uploaded');
})

app.get('/file',async(req,res)=>{
    let {userId} = req.query;
    const storage = getStorage();
    const listRef = sref(storage, 'users/' + userId + '/files/');
    let listData=[];
    const resList = await listAll(listRef);
    resList.items.map(itemRef => {
        const fileName = itemRef.name;
        const fileType = fileName.match(/(\.jpg|\.jpeg|\.png|\.gif)$/) ? 'image' : fileName.match(/\.pdf$/) ? 'pdf' : fileName.match(/\.doc$|\.docx$/) ? 'doc' : fileName.match(/\.xls$|\.xlsx$/) ? 'xlsx' : fileName.match(/\.ppt$|\.pptx$/) ? 'pptx' : fileName.match(/\.txt$/) ? 'txt' : fileName.match(/\.mp3|\.wav|\.m4a|\.aac|\.ogg|\.flec/) ? 'audio' : fileName.match(/\.mp4$|\.mov$|\.avi$|\.mp4|\.mkv|\.3gp/) ? 'video' : 'other';
        getDownloadURL(itemRef).then((downloadURL) => {
            listData = [...listData, { fileName, fileType, downloadURL }];
            if (listData.length === resList.items.length) {
                res.send(listData);
            }
        })
    })
})