const isAndroid = () => /(android)/i.test(typeof navigator !== 'undefined' ? navigator.userAgent : '')
export default isAndroid
