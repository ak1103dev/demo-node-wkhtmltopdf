const fs = require('fs');
const wkhtmltopdf = require('wkhtmltopdf');

wkhtmltopdf('http://google.com/', { pageSize: 'letter' })
  .pipe(fs.createWriteStream('out.pdf'));
