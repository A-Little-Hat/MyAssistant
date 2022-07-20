const icon = (fileType) => {
    switch (fileType) {
        case 'pdf':
            return 'https://www.svgrepo.com/show/66745/pdf.svg'
        case 'doc':
            return 'https://www.svgrepo.com/show/146474/doc.svg'
        case 'image':
            return 'https://www.svgrepo.com/show/28161/image.svg'
        case 'video':
            return 'https://www.svgrepo.com/show/226516/video.svg'
        case 'audio':
            return 'https://www.svgrepo.com/show/256694/audio-mp3.svg'
        case 'xlsx':
            return 'https://www.svgrepo.com/show/19987/excel.svg'
        case 'pptx':
            return 'https://www.svgrepo.com/show/42254/ppt.svg'
        default:
            return 'https://www.svgrepo.com/show/27447/document.svg'
    }
}
export default icon