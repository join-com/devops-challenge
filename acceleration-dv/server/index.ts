import * as http from 'http';
import * as url from 'url';

const port = process.env.WEB_PORT!;

const status = {
  fail: false,
};

const server = http.createServer((req, res) => {
  if (status.fail) {
    res.writeHead(500, { 'Content-Type': 'text/html' });
    res.end('Something wrong');
    return;
  }
  const { pathname, query } = url.parse(req.url!, true);
  switch (pathname) {
    case '/health':
      res.writeHead(200, { 'Content-Type': 'text/html' });
      res.end('Ok!');
      break;
    case '/dv':
      const dv = Number(query.vf) - Number(query.vi);
      res.writeHead(200, { 'Content-Type': 'application/json' });
      res.end(
        JSON.stringify({
          dv,
        }),
      );
      break;
    default:
      res.writeHead(404, { 'Content-Type': 'text/html' });
      res.end('Not Found');
      break;
  }
});

server.listen(port, (err: Error) => {
  if (err) {
    return console.log('something bad happened', err);
  }

  console.log(`server is listening on ${port}`);
});

setTimeout(() => {
  status.fail = true;
}, Math.random() * 300000);
