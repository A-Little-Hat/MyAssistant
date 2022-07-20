import React, { useState } from 'react'

import './login.css'

const Login = ({ authStateChange }) => {
    const [email, setEmail] = useState('')
    const [password, setPassword] = useState('')
    const appName = 'MyAssistant'
    return (
        <div className="main" style={{
            fontFamily: `'Nunito', sans-serif`
        }}>
            <aside className="profile-card">
                <header>
                    {/* <img src={hacker} alt="user_icon" height="110px" /> */}
                    <div className="loginlogo">
                        <div className="rainbow-container">
                            <div className="green"></div>
                            <div className="yellow"></div>
                            <div className="pink"></div>
                            <div className="blue"></div>
                        </div>
                    </div>
                    <h1 id="name" >
                        {/* <Typical
                            steps={['', 1000, 'My', 1000, 'MyAssistant', 100]}
                            loop={Infinity}
                        /> */}
                        MyAssistant
                    </h1>
                    
                </header>
                <div className="profile-bio">
                    <form className="form-control" >
                        <div className="inputDiv">
                            <label htmlFor="Email">Email</label>
                            <input className="field" type="email" name="Email" id="Email" value={email} onChange={(e) => {
                                setEmail(e.target.value)
                            }} />
                        </div>
                        <div className="inputDiv">
                            <label htmlFor="password">Password</label>
                            <input className="field" type="password" name="password" id="password" value={password} onChange={(e) => {
                                setPassword(e.target.value)
                            }} />
                        </div>
                        <button className="btn btn-primary myBtn" type="submit" onClick={async (e) => {
                            e.preventDefault();
                            const url = 'https://myassistantbackend.herokuapp.com/login?email=' + email + '&password=' + password
                            const response = await fetch(url, {
                                method: 'POST',
                                mode: 'cors',
                                cache: 'no-cache',
                                headers: {
                                    'Content-Type': 'application/json'
                                },
                            });
                            const { auth, code } = await response.json(); // parses JSON response into native JavaScript 
                            console.log(auth, code);
                            authStateChange(auth, code)
                        }} >Login</button>
                    </form>
                </div>
            </aside>
        </div>
    )
}

export default Login