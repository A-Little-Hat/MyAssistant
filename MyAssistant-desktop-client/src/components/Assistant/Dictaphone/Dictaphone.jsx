import React, { useState, useEffect } from 'react'
import { useSpeechRecognition } from '../core/SpeechRecognition'
// import Button from 'react-bootstrap/Button'
import Lottie from 'react-lottie';
import animationData from '../assets/hello.json'
import onData from '../assets/on.json'
import mic from '../assets/micwh.png'
import { stopDictophone, listenContinuously } from '../app/Dictaphones'


const Dictaphone = ({ commands }) => {

  const defaultOptions = {
    loop: true,
    autoplay: true,
    animationData: animationData,
    rendererSettings: {
      // preserveAspectRatio: "xMidYMid slice"
    }
  };
  const onOptions = {
    loop: true,
    autoplay: true,
    animationData: onData,
  }
  const offOptions = {
    loop: false,
    autoplay: false,
    animationData: onData,
  }
  const [transcribing, setTranscribing] = useState(true)
  const [clearTranscriptOnListen, setClearTranscriptOnListen] = useState(true)
  let {
    transcript,
    interimTranscript,
    finalTranscript,
    resetTranscript,
    listening,
    setListening,
    browserSupportsSpeechRecognition,
    isMicrophoneAvailable,
  } = useSpeechRecognition({ transcribing, clearTranscriptOnListen, commands })
  useEffect(() => {
    if (interimTranscript !== '') {
      console.log('Got interim result:', interimTranscript)
    }
    if (finalTranscript !== '') {
      console.log('Got final result:', finalTranscript)
    }
  }, [interimTranscript, finalTranscript]);

  if (!browserSupportsSpeechRecognition) {
    return <span>No browser support</span>
  }

  if (!isMicrophoneAvailable) {
    return <span>Please allow access to the microphone</span>
  }

  return (
    <>
      <div style={{
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        // width: '100%',
        // backgroundColor: "rgb(255,100,75)",
        height: '100%',
    }}>
      <Lottie
        options={defaultOptions}
        height={400}
        width={400}
      />
      <h1>
        {finalTranscript}
      </h1>
      <div style={{
        marginTop: '',
      }} >
        {
          listening ? (
            <>
              <button  onClick={
                () => {
                  stopDictophone()
                  resetTranscript()
                }
              }
                style={{
                  borderRadius: '50px',
                  border: 'none',
                  outline: 'none',
                  background: 'none',
                }}
              >
                <Lottie
                options={onOptions}
                height={120}
                width={120}
                />
                {/* <img src="https://www.svgrepo.com/show/349814/mic.svg" width="30px" height="30px" /> */}
              </button>
            </>
          ) : (
            <>
              <button onClick={
                () => {
                  listenContinuously();
                  setTimeout(() => {
                    stopDictophone();
                    resetTranscript();
                  }, 5000)
                }
              }
                style={{
                  borderRadius: '50px',
                  border: 'none',
                  outline: 'none',
                  background: 'none',
                }}
              >
                <button style={{
                  backgroundColor:'#3063AB',
                  borderRadius:'50px',
                  minHeight:'90px',
                  minWidth:'90px',
                  color:'white'
                }}>
                <img src={mic} style={{
                    height:'50px',
                    
                }} />
                </button>
                
                {/* <img src="https://www.svgrepo.com/show/305514/mic-off-outline.svg" width="30" height="30" /> */}

              </button>
            </>
          )
        }
      </div>
      {/* <div>
        {
          listening ?
          (
            <div >
                listening
            </div>
          ) :
          (<></>)
        }
      </div> */}
    </div>
    </>
  )
}

export default Dictaphone