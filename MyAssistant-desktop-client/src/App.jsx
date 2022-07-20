import React, { useState, useEffect } from 'react'

// import File from './components/File'
import Assistant from './components/Assistant'
import Login from './components/Login'
function App() {
  const [auth, setAuth] = useState('false')
  const [userId, setUserId] = useState('')
  useEffect(() => {
    console.log(localStorage.getItem('auth'))
    setAuth(localStorage.getItem('auth') === 'true')
    console.log(auth)
  },[])
  useEffect(()=>{
    console.log('auth : '+auth)
  },[auth])
  
  const authStateChange = (isAuth,id) =>{
    localStorage.setItem('auth',isAuth);
    localStorage.setItem('assistantUserId',id);
    setUserId(id);
    setAuth(isAuth);
  }
  return (
    <div className="App">
      {
        auth===true ? <Assistant authStateChange={authStateChange} /> : <Login authStateChange={authStateChange} />
        // auth===true ? <File /> : <Login authStateChange={authStateChange} />
      }
    </div>
  )
}

export default App
