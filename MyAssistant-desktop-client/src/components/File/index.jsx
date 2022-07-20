import React,{ useState, useEffect } from 'react'
import FileCard from './FileCard'
import Button from 'react-bootstrap/Button'
import './file.css'
import './background.css'
import Lottie from 'react-lottie';
import animationData from './assets/empty.json'

const File = ({setIsFile}) => {  
  const defaultOptions = {
    loop: false,
    autoplay: true,
    animationData: animationData,
    rendererSettings: {
      // preserveAspectRatio: "xMidYMid slice"
    }
  };
    const [files, setFiles] = useState([])
    useEffect(() => {
        const uid = localStorage.getItem('assistantUserId');
        fetch('https://myassistantbackend.herokuapp.com/file?userId='+uid,{
          'Access-Control-Allow-Origin':'*'
        }).then(data=>{
          return data.json();
        }).then(result=>{
          let temp = []
          result.map(file=>{
            temp = [...temp, file]
          })
          setFiles(temp)
          console.log(files)
        })
    }, [])
    
    return (
      <div className="fileMainDiv" style={{
        // backgroundImage: 'linear-gradient(to right, #9229f4, #972ff2, #9c34f1, #a139ef, #a53eee, #a64cee, #a858ee, #aa63ed, #ab76ec, #ae86e9, #b296e6, #b7a5e1)',
        fontFamily: `'Nunito', sans-serif`,
        // marginTop: '5%'
        
      }} >
        <div style={{
          display: 'flex',
          flexDirection: 'row',
          width: '100%',
          justifyContent: 'space-between',
          alignItems: 'center',
          paddingLeft : '10px',
          paddingRight : '10px',
          fontFamily: `'Nunito', sans-serif`,
        }}>
          <div>
            <button style={{
              border: 'none',
              cursor: 'pointer',
              background: 'transparent'
            }}
            onClick={() => {
              setIsFile(false)
              localStorage.setItem('file',false);
            }}
            ><h1><b style={{
              color : 'white',
            }}>MyAssistant</b></h1></button>
          </div>
          <div><h1><b style={{
            color : 'white',
          }}>MyFiles</b></h1></div>
          <Button variant="outline-primary" onClick={()=>{
            window.location.reload()
            setIsFile(true);
            localStorage.setItem('file',true);
          }}
          style={{
            backgroundColor: 'rgba(0,0,0,0)',
            border: 'none',
            cursor: 'pointer',
          }} >
          <img src='https://www.svgrepo.com/show/76385/refresh.svg' alt="refresh" style={{width: '50px', height: '50px'}} />
          </Button>
        </div>
        <section className="basic-grid" style={{
          padding: '1%'
        }}>
      {files.length>0 ?
      files.map((file, index) => {
        return (
          <FileCard key={index} file={file} />
          ) 
        }) :
        <div style={{
          display: 'flex',
          justifyContent: 'center',
          minWidth: '98vw'
          // width: '100vw',
          // alignItems: 'center',
        }}> 
        <div className='container-fluid' >
        <Lottie
        options={defaultOptions}
        height={400}
        width={400}
        />
          <div style={{
            display: 'flex',
            justifyContent: 'center',

          }}>
              <h1>
                  No Files Uploaded Yet
              </h1>
          </div>
        </div>
        </div>
      }
        </section>
      </div>
    )
  }

export default File