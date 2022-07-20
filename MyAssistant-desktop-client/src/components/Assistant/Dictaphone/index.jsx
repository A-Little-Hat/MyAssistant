import React from 'react'
import './dictaphone.module.css'
import DictaphoneWidgetA from './DictaphoneWidgetA'

export { DictaphoneWidgetA}


const Assistant = ({authStateChange}) => {
  return (
      <>
    <DictaphoneWidgetA authStateChange={authStateChange} />
    </>
  )
}

export default Assistant