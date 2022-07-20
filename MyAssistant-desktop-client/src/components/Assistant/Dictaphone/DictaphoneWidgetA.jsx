import React, { useState } from 'react'
import Dictaphone from './Dictaphone'
import { stopDictophone } from '../app/Dictaphones'


import speakOut from '../../../javascript/speak'
import File from '../../File'
import './background.css'


const DictaphoneWidgetA = ({ authStateChange }) => {
  const [message, setMessage] = useState('')
  const [isfile, setIsFile] = useState(localStorage.getItem('file') === 'true')
  const commands = [
    {
      command: ['Good Morning', 'good morning', 'goodmorning', 'supravat', 'suprovat', 'su provat', 'suprabhat', 'suprobhat'],
      callback: () => {
        speakOut(`Wishing You a very Good Morning.!`);
        let keyword = `Wishing You a very Good Morning.!`
        setMessage(keyword);
        stopDictophone();
        setTimeout(() => {
          setMessage('');
        }, 4000)
      }
    },
    {
      command: ['Good Night', 'good Night', 'goodNight', 'subhratri', 'subh ratri', ],
      callback: () => {
        speakOut(`Wishing You a very Good Night.!.. Sweet Dreams.`);
        let keyword = `Wishing You a very Good Night.!`
        setMessage(keyword);
        stopDictophone();
        setTimeout(() => {
          setMessage('');
        }, 4000)
      }
    },
    {
      command: ['Good evening', 'good evening', 'goodevening',],
      callback: () => {
        speakOut(`Wishing You a very Good evening.!`);
        let keyword = `Wishing You a very Good evening.!`
        setMessage(keyword);
        stopDictophone();
        setTimeout(() => {
          setMessage('');
        }, 4000)
      }
    },
    {
      command: ['Good afternoon', 'good afternoon', 'goodafternoon',],
      callback: () => {
        speakOut(`Wishing You a very Good afternoon.!`);
        let keyword = `Wishing You a very Good afternoon.!`
        setMessage(keyword);
        stopDictophone();
        setTimeout(() => {
          setMessage('');
        }, 4000)
      }
    },
    {
      command: ['Help', 'commands', 'show command', 'show commands','view command','view commands',],
      callback: () => {
        window.open('https://a-little-hat.github.io/myassistant/pages/guide.html')
        // setMessage(keyword);
        stopDictophone();
        setTimeout(() => {
          setMessage('');
        }, 4000)
      }
    },
    {
      command: 'weather in *',
      callback: async (city) => {
        speakOut('finding');
        let keyword = `weather in ${city}`
        window.open('http://google.com/search?q=' + keyword)
        stopDictophone()
        setTimeout(() => {
          setMessage('');
        }, 4000)
      }
    },
    {
      command: ['Hello', 'Hi', 'hey', 'howdy', 'helo', 'holla', 'hola', 'hai', 'hii', 'hoo'],
      callback: () => {
        setMessage(`Hi there! What's going on?`);
        stopDictophone();
        speakOut(message)
        setTimeout(() => {
          setMessage('');
        }, 4000)
      },
      matchInterim: true
    },
    {
      command: ['logout', 'log out', 'log me out', 'logmeout', 'session out', 'signout', 'sign out', 'sign me out', 'lock me out', 'lockout', 'lock me out'],
      callback: () => {
        const auth = 'false';
        const id = '';
        stopDictophone();
        speakOut('logging out');
        setTimeout(() => {
          localStorage.setItem('file', false)
          localStorage.setItem('assistantUserId', '')
          authStateChange(auth, id);
        }, 1000)
      },
    },
    {
      command: 'open *',
      callback: (site) => {
        let regex = /(^[A-Za-z0-9]+.(com|org|co|net)$)/m
        let url = ''
        if (regex.exec(site)) {
          url = 'https://' + site
        } else {
          url = 'https://www.' + site + '.com'
        }
        setMessage(`Opening ${site}`)
        stopDictophone()
        speakOut(message)
        setTimeout(() => {
          window.open(url);
        }, 2000)
        setTimeout(() => {
          setMessage('');
        }, 4000)
      },
    },
    {
      command: ['clear', 'reset', 'clean'],
      callback: ({ resetTranscript }) => {
        resetTranscript()
        stopDictophone()
      },
      matchInterim: true
    },
    {
      command: ['view myfiles', 'view my files', 'view my file', 'browse my files', 'browse myfiles', 'browse my file'],
      callback: () => {
        setMessage(`Opening your files`)
        stopDictophone()
        speakOut(message)
        localStorage.setItem('file', true)
        setIsFile(true)
        setTimeout(() => {
          setMessage('');
        }, 4000)
      },
      matchInterim: true
    },
    {
      command: 'my name is *',
      callback: (name) => {
        setMessage(`Hi ${name}!`)
        stopDictophone()
        const temp = message
        setTimeout(() => {
          setMessage('');
          speakOut(temp)
        }, 4000)
      },
      matchInterim: true
    },
    {
      command: ['Goodbye', 'bye', 'see you soon', 'tata', 'exit', 'quit', 'leave the chat', 'close', 'end', 'stop'],
      callback: () => {
        setMessage('Thanks for using Assiatant!');
        stopDictophone()
        speakOut(message)
        setTimeout(() => {
          setMessage('');
        }, 4000)
      },
      matchInterim: true
    },
    {
      command: 'play *',
      callback: (song) => {
        speakOut('playing in a while.')
        setMessage(`Playing ${song}`)
        stopDictophone()
        setTimeout(() => {
          window.open('http://google.com/search?q=youtube:' + song);
        }, 2000)
      }
    },
    {
      command: ['what is *'],
      callback: (query) => {
        setMessage(`looking for ${query}`)
        stopDictophone()
        setTimeout(() => {
          window.open('http://google.com/search?q=what is ' + query);
        }, 2000)
      }
    },
    {
      command: ['who is *'],
      callback: (query) => {
        setMessage(`looking for ${query}`)
        stopDictophone()
        window.open('http://google.com/search?q=who is ' + query);
      }
    },
    {
      command: ['what is the *'],
      callback: (query) => {
        setMessage(`looking for the ${query}`)
        stopDictophone()
        window.open('http://google.com/search?q=what is the ' + query);
      }
    },
    {
      command: ['how *'],
      callback: (query) => {
        setMessage(`finding how to ${query}`)
        stopDictophone()
        window.open('http://google.com/search?q=how to ' + query);
      }
    },
  ]

  return (
    <div >
      {
        isfile ? 
        <File setIsFile={setIsFile} /> : 
        <div className="dicMainDiv" >
          <div style={{
          display: 'flex',
          flexDirection: 'column',
          alignItems: 'center',
          paddingTop: '2%',
          minHeight: '90vh',
          width: '90vw',
          background: `rgba(255, 255, 255, 0.68)`,
          borderRadius: `16px`,
          boxShadow: `0 4px 30px rgba(0, 0, 0, .5)`,
          backdropFilter: `blur(4.8px)`,
        // - webkit - backdrop - filter: `blur(3.8px)`,
          border: `1px solid rgba(255, 255, 255, 0.4)`,
        }}>
          <h1 style={{
            fontSize: '3rem'
          }}>
            MyAssistant
          </h1>
          <p style={{
            fontSize: '1.5rem',
            fontWeight: 'bold',
            marginBottom: '1rem',
          }}>{message}</p>
          <Dictaphone commands={commands} />
        </div>
    </div>
    }
    </div>
  )
}

export default DictaphoneWidgetA