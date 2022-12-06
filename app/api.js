const express = require('express')
const app = express()

app.use(express.static(__dirname))

app.listen(8000, () => {
    console.log('\nServidor rodando na porta 8000')
    console.log('\x1b[36m%s\x1b[0m', 'http://localhost:8000');
})

app.get('/', (req, res) => {
    res.sendFile(__dirname + '/index.html')
})

app.get('/admin', (req, res) => {
    res.sendFile(__dirname + '/admin.html')
})