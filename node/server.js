const http = require("http");
const fs = require("fs");
const os = require("os");
const ip = require('ip');
const { uptime } = require("process");

http.createServer((req, res) => {
  if (req.url === "/") {
      fs.readFile("./public/index.html", "UTF-8", (err, body) => {
      res.writeHead(200, {"Content-Type": "text/html"});
      res.end(body);
    });
  } else if(req.url.match("/sysinfo")) {
    //Host Name
        myHostName=os.hostname();
    //Days Hours Minutes Seconds
        var ut_sec = os.uptime();
        var ut_min = ut_sec/60;
        var ut_hour = ut_min/60;
        var ut_day = ut_hour/24;
   
        ut_sec = Math.floor(ut_sec);
        ut_min = Math.floor(ut_min);
        ut_hour = Math.floor(ut_hour);
        ut_day = Math.floor(ut_day);
  
        ut_day = ut_day%60;
        ut_hour = ut_hour%60;
        ut_min = ut_min%60;
        ut_sec = ut_sec%60;
  
        finalFormat=( "Days: " + ut_day
            + ", Hours: " + ut_hour 
            + ", Minutes: " + ut_min 
            + ", Seconds: " + ut_sec
        );
    //Total Mem in MB
        var total_memory = os.totalmem();
        var total_mem_in_mb = total_memory/1048576;
       
        total_mem_in_mb = total_mem_in_mb.toFixed(3);
     
        totalMemMB=(total_mem_in_mb + " MB");
    //Free Mem in MB
        var free_memory = os.freemem();
        var free_mem_in_mb = free_memory/1048576;
   
        free_mem_in_mb = free_mem_in_mb.toFixed(3);
 
        freeMemMB=(free_mem_in_mb + " MB");
    //Number of CPUs
        var cpu_s=os.cpus();
        var no_of_logical_core=0;
        cpu_s.forEach(element => { 
            no_of_logical_core++;
            console.log("Logical core "
                + no_of_logical_core + " :");
            console.log(element); 
        }); 
      
        totalCPU=(no_of_logical_core);
    //Sysinfo Page
    html=`
    <!DOCTYPE html>
    <html>
      <head>
        <title>Node JS Response</title>
      </head>
      <body>
        <p>Hostname: ${myHostName}</p>
        <p>IP: ${ip.address()}</p>
        <p>Server Uptime: ${finalFormat}</p>
        <p>Total Memory: ${totalMemMB}</p>
        <p>Free Memory: ${freeMemMB}</p>
        <p>Number of CPUs: ${totalCPU}</p>
      </body>
    </html>`
    res.writeHead(200, {"Content-Type": "text/html"});
    res.end(html);
  } else {
    res.writeHead(404, {"Content-Type": "text/plain"});
    res.end(`404 File Not Found at ${req.url}`);
  }
}).listen(3000);

console.log("Server listening on port 3000");