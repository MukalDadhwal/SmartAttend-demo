const express = require("express");
const app = express();
const http = require("http");
const server = http.createServer(app);
const { Server } = require("socket.io");
const io = new Server(server, {
  cors: {
    origin: "*",
    methods: ["GET", "POST", "PUT"],
  },
});

let PORT = 3000;

function pauseSocket(duration) {
  isPaused = true;
  setTimeout(() => {
    isPaused = false;
  }, duration);
}

io.on("connection", (socket) => {
  console.log("a user connected");
  socket.emit("server", "Hey fluter app!!");

  socket.on("disconnect", () => {
    console.log("User has disconnected");
  });

  socket.on("client", (data) => {
    console.log("Socket connected");
    console.log(`client sent: ${data}`);

    if (data == "hey") {
      console.log("Msg accknowleged");
      socket.emit("server", "hello");

      // setTimeout(() => {
      //   // socket.disconnect();
      // }, 5000);
    }
  });
});

server.listen(PORT, () => {
  console.log("listening on 3000");
});
