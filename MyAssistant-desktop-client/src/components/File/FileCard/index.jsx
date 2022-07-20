import React from 'react'
import icon from '../../../javascript/icon'
import Button from 'react-bootstrap/Button'

const FileCard = ({ file }) => {
    const { fileName, fileType, downloadURL } = file
    const iconLink = icon(fileType)
    return (
        <div className="card" >
            <div style={{
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                padding: '1%',
            }}>
                <img src={iconLink} alt="icon" style={{
                    width: '50px',
                    height: '50px',
                }} />
                <div style={{
                    display:'flex',
                    overflowX:'hidden'
                }}>
                    <h1>{fileName.slice(0, 10)}</h1>
                </div>
                <a href={downloadURL} style={{
                    marginTop: '50px',
                }} >
                    <Button>
                        Download
                    </Button>
                </a>
            </div>
        </div>
    )
}

export default FileCard