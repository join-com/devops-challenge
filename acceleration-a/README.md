
# Note:

Removed following line of code from the file "server/index.ts" to avoid the Timeout

```bash
setTimeout(() => {
  status.fail = true;
}, Math.random() * 300000);
```
