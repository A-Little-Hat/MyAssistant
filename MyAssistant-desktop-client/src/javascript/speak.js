const speakOut = (msg) => {
    // const length = msg.length
    console.log(msg)
    const synth = window.speechSynthesis;
    const toSpeak = new SpeechSynthesisUtterance(msg);
    synth.speak(toSpeak);
}
export default speakOut;