import * as http from 'http';
import * as request from 'request-promise-native';
import * as url from 'url';

const port = process.env.WEB_PORT!;
const dvUrl = process.env.DV_URL!;
const aUrl = process.env.A_URL!;

const calc = async (query: any) => {
  const dvResult = await request.get(`${dvUrl}?vf=${query.vf}&vi=${query.vi}`);
  const dv = JSON.parse(dvResult).dv;
  const aResult = await request.get(`${aUrl}?dv=${dv}&t=${query.t}`);
  return JSON.parse(aResult).a;
};

const server = http.createServer((req, res) => {
  const { pathname, query } = url.parse(req.url!, true);
  switch (pathname) {
    case '/health':
      res.writeHead(200, { 'Content-Type': 'text/html' });
      res.end('Ok!');
      break;
    case '/calc':
      calc(query)
        .then(a => {
          res.writeHead(200, { 'Content-Type': 'application/json' });
          res.end(
            JSON.stringify({
              a,
            }),
          );
        })
        .catch(() => {
          res.writeHead(500, { 'Content-Type': 'text/html' });
          res.end('something wrong');
        });

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
