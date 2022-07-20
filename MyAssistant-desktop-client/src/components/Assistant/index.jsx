import React from 'react'
import Dictaphones from './app/Dictaphones'
const Assistant = ({ authStateChange }) => {

  return (
    <div style={{
      // backgroundImage: 'linear-gradient(to right, #9229f4, #972ff2, #9c34f1, #a139ef, #a53eee, #a64cee, #a858ee, #aa63ed, #ab76ec, #ae86e9, #b296e6, #b7a5e1)'
      // background: '#03001e',
      // background: '-webkit-linear-gradient(to bottom, #f55c7a, #492957)',
      // background: 'linear-gradient(to bottom, #f55c7a, #492957)',
      // backgroundImage: `url('https://images.unsplash.com/photo-1548266652-99cf27701ced?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80')`,
      // background: `linear-gradient(0deg, rgba(178,145,255,1) 43%, rgba(255,255,255,1) 100%)`,
      fontFamily: `'Nunito', sans-serif`,
      backgroundRepeat: 'no-repeat' ,
      backgroundSize: '100%' ,
    }}>
      <Dictaphones authStateChange={authStateChange} />
    </div>
  )
}

export default Assistant